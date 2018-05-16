//
//  PurchaseServices.swift
//  BetTip
//
//  Created by Haydar Karkin on 15.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import RxSwift
import StoreKit
import SwiftyStoreKit

private let logger = Log.createLogger()

let PRODUCT_OCR_10 = "ios_ocr_purchase_10"
let PRODUCT_OCR_50 = "ios_ocr_purchase_50"
let PRODUCT_PLUS = "ios_plus_sku_2"

protocol PurchaseServiceType {
    
}

// Global Cached Validation
typealias SubscriptionValidation = (valid: Bool, expireTime: Date?)
private var cachedValidation: SubscriptionValidation?

class PurchaseService: PurchaseServiceType {
    static fileprivate var cachedProducts = [SKProduct]()
    let bag = DisposeBag()
    
    func requestProducts() -> Observable<SKProduct> {
        let ids: Set = [PRODUCT_PLUS, PRODUCT_OCR_10, PRODUCT_OCR_50]
        return Observable<SKProduct>.create({ observer -> Disposable in
            SwiftyStoreKit.retrieveProductsInfo(ids) { result in
                for product in result.retrievedProducts {
                    observer.onNext(product)
                }
            }
            return Disposables.create()
        }).do(onError: { error in
            let errorEvent = ErrorEvent(error: error)
            AnalyticsManager.sharedManager.record(event: errorEvent)
        })
    }
    
    func restorePurchases() -> Observable<[Purchase]> {
        return Observable<[Purchase]>.create({ observable -> Disposable in
            SwiftyStoreKit.restorePurchases(atomically: true) { results in
                if !results.restoredPurchases.isEmpty {
                    logger.log(.debug, "Restore Success: \(results.restoredPurchases)")
                    observable.onNext(results.restoredPurchases)
                } else if !results.restoreFailedPurchases.isEmpty {
                    logger.log(.debug, "Restore Failed: \(results.restoreFailedPurchases)")
                    observable.onError(results.restoreFailedPurchases.first!.0)
                } else {
                    logger.log(.debug, "Nothing to Restore")
                    observable.onNext([])
                }
            }
            return Disposables.create()
        })
    }
    
    func purchase(prodcutID: String) -> Observable<PurchaseDetails> {
        return Observable<PurchaseDetails>.create({ observer -> Disposable in
            SwiftyStoreKit.purchaseProduct(prodcutID, atomically: true) { result in
                switch result {
                case .success(let purchase):
                    logger.log(.debug, "Purchase Success: \(purchase.productId)")
                    observer.onNext(purchase)
                case .error(let error):
                    switch error.code {
                    case .unknown: logger.log(.error, "Unknown error. Please contact support")
                    case .clientInvalid: logger.log(.error, "Not allowed to make the payment")
                    case .paymentCancelled: break
                    case .paymentInvalid: logger.log(.error, "The purchase identifier was invalid")
                    case .paymentNotAllowed: logger.log(.error, "The device is not allowed to make the payment")
                    case .storeProductNotAvailable: logger.log(.error, "The product is not available in the current storefront")
                    case .cloudServicePermissionDenied: logger.log(.error, "Access to cloud service information is not allowed")
                    case .cloudServiceNetworkConnectionFailed: logger.log(.error, "Could not connect to the network")
                    case .cloudServiceRevoked: logger.log(.error, "User has revoked permission to use this cloud service")
                    }
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }).do(onNext: { [weak self] _ in
            logger.log(.debug, "Successful purchase: \(prodcutID)")
            PurchaseService.analyticsPurchaseSuccess(productID: prodcutID)
            self?.sendReceipt()
            }, onError: { _ in
                logger.log(.error, "Failed purchase: \(prodcutID)")
                PurchaseService.analyticsPurchaseFailed(productID: prodcutID)
        })
    }
    
    func restoreSubscription() -> Observable<Bool> {
        return restorePurchases()
            .map({ purchases -> Bool in
                return purchases.contains(where: { $0.productId == PRODUCT_PLUS })
            }).do(onNext: { restored in
                if restored {
                    logger.log(.debug, "Successfuly restored Subscription")
                    NotificationCenter.default.post(name: NSNotification.Name.betTipAdsRemoved, object: nil)
                }
            })
    }
    
    func purchaseSubscription() -> Observable<PurchaseDetails> {
        return purchase(prodcutID: PRODUCT_PLUS)
            .do(onNext: { [weak self] _ in
                self?.resetCache()
                logger.log(.debug, "Successful restore PLUS Subscription")
                NotificationCenter.default.post(name: NSNotification.Name.betTipAdsRemoved, object: nil)
                }, onError: handleError(_:))
    }
    
    func price(productID: String) -> Observable<String> {
        return requestProducts()
            .filter({ $0.productIdentifier == productID })
            .map({ $0.localizedPrice })
    }
    
    private func handleError(_ error: Error) {
        let responseError = error as NSError
        if responseError.code == SKError.paymentCancelled.rawValue && responseError.domain == SKErrorDomain {
            logger.log(.error, "Cancelled by User")
            return
        } else {
            logger.log(.error, "Unknown error: \(error.localizedDescription)")
            let errorEvent = ErrorEvent(error: responseError)
            AnalyticsManager.sharedManager.record(event: errorEvent)
        }
    }
    
    private func isCachedProduct(id: String) -> Bool {
        for product in PurchaseService.cachedProducts where product.productIdentifier == id {
            return true
        }
        return false
    }
    
    func completeTransactions() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.productId == PRODUCT_PLUS {
                        NotificationCenter.default.post(name: NSNotification.Name.betTipAdsRemoved, object: nil)
                    }
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }
    }
}

// MARK: PurchaseService and Subscription
extension PurchaseService {
    func resetCache() {
        cachedValidation = nil
    }
    
    func cacheSubscriptionValidation() {
        validateSubscription()
            .do(onNext: { cachedValidation = $0 })
            .subscribe(onNext: { validation in
                logger.log(.debug, "Cached Validation: Valid = \(validation.valid), expire: \(String(describing: validation.expireTime))")
            }, onError: { error in
                logger.log(.error, error.localizedDescription)
            }).disposed(by: bag)
    }
    
    func hasValidSubscriptionValue() -> Bool {
        guard let cached = cachedValidation else { return false }
        return cached.valid
    }
    
    func hasValidSubscription() -> Observable<Bool> {
        return validateSubscription().map({ validation -> Bool in
            return validation.valid
        })
    }
    
    func subscriptionExpirationDate() -> Observable<Date?> {
        return validateSubscription().map({ validation -> Date? in
            return validation.expireTime
        })
    }
    
    func validateSubscription() -> Observable<SubscriptionValidation> {
        if DebugStates.subscription() {
            return Observable<SubscriptionValidation>.just((true, Date.distantFuture))
        } else if let validation = cachedValidation {
            return Observable<SubscriptionValidation>.just(validation)
        }
        
        return Observable<SubscriptionValidation>.create({ [weak self] observable -> Disposable in
            let service: AppleReceiptValidator.VerifyReceiptURLType = DebugStates.isDebug ? .sandbox : .production
            let validator = AppleReceiptValidator(service: service, sharedSecret: nil)
            SwiftyStoreKit.verifyReceipt(using: validator) { receiptResult in
                switch receiptResult {
                case .success(let receipt):
                    guard let purchaseResult = self?.verifySubscription(receipt: receipt) else { return }
                    switch purchaseResult {
                    case .purchased(let expiryDate, _):
                        observable.onNext((true, expiryDate))
                    case .expired(let expiryDate, _):
                        observable.onNext((false, expiryDate))
                    case .notPurchased:
                        observable.onNext((false, nil))
                    }
                    
                case .error(let error):
                    observable.onError(error)
                }
                observable.onCompleted()
            }
            return Disposables.create()
        }).catchError({ error -> Observable<SubscriptionValidation> in
            logger.log(.error, error.localizedDescription)
            return Observable<SubscriptionValidation>.just((false, nil))
        }).do(onNext: { cachedValidation = $0 })
    }
    
    func verifySubscription(receipt: ReceiptInfo) -> VerifySubscriptionResult {
        return SwiftyStoreKit.verifySubscription(ofType: .nonRenewing(validDuration: TimeInterval.year), productId: PRODUCT_PLUS, inReceipt: receipt)
    }
}

// MARK: Purchase Analytics
extension PurchaseService {
    fileprivate static func analyticsPurchaseSuccess(productID: String) {
        let anEvent =  Event.Purchases.PurchaseSuccess
        anEvent.dataPoints.append(DataPoint(name: "sku", value: productID))
        AnalyticsManager.sharedManager.record(event: anEvent)
    }
    
    fileprivate static func analyticsPurchaseFailed(productID: String) {
        let anEvent =  Event.Purchases.PurchaseFailed
        anEvent.dataPoints.append(DataPoint(name: "sku", value: productID))
        AnalyticsManager.sharedManager.record(event: anEvent)
    }
}

// MARK: Recipt
extension PurchaseService {
    func appStoreReceipt() -> String? {
        guard let receiptURL = Bundle.main.appStoreReceiptURL else { return nil }
        guard let receipt = try? Data(contentsOf: receiptURL) else { return nil }
        return receipt.base64EncodedString()
    }
    
    func isReceiptSent(_ receipt: String) -> Bool {
        return UserDefaults.standard.bool(forKey: receipt)
    }
    
    func sendReceipt() {
        if UserEventService.shared.user.value == nil {
            logger.log(.warning, "Can't send receipt: User are not logged in!")
            return
        }
        guard let receiptString = appStoreReceipt() else { return }
        if isReceiptSent(receiptString) {
            logger.log(.warning, "Can't send receipt: Receipt is sent before")
            return
        }
        
        let params = ["encoded_receipt": receiptString,
                      "pay_service": "Apple Store",
                      "goal": "Recognition"]
        
        logger.log(.debug, "receipt params: \(params)")
    }
    
    func logPurchases() {
        let service: AppleReceiptValidator.VerifyReceiptURLType = DebugStates.isDebug ? .sandbox : .production
        let validator = AppleReceiptValidator(service: service, sharedSecret: nil)
        SwiftyStoreKit.verifyReceipt(using: validator) { [weak self] receiptResult in
            switch receiptResult {
            case .success(let receipt):
                guard let purchaseResult = self?.verifySubscription(receipt: receipt) else { return }
                logger.log(.debug, "=== Purchases info ===")
                switch purchaseResult {
                case .purchased(_, let items):
                    self?.logReceiptItems(items)
                case .expired(_, let items):
                    self?.logReceiptItems(items)
                case .notPurchased: break
                }
                logger.log(.debug, "======================")
            case .error(let error):
                logger.log(.error, error.localizedDescription)
            }
        }
    }
    
    private func logReceiptItems(_ items: [ReceiptItem]) {
        for item in items {
            logger.log(.debug, "===== Purchase Item: \(item.productId) ====")
            logger.log(.debug, "Purchase: \(item.purchaseDate)")
            logger.log(.debug, "Original purchase: \(item.originalPurchaseDate)")
            guard let expire = item.subscriptionExpirationDate else { continue }
            logger.log(.debug, "Expire: \(expire)")
        }
    }
}

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)!
    }
}

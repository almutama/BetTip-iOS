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

protocol PurchaseServiceType {
    
}

class PurchaseService: PurchaseServiceType {
    func requestProducts() -> Observable<SKProduct> {
        let ids: Set = [PRODUCT_OCR_10, PRODUCT_OCR_50]
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
}

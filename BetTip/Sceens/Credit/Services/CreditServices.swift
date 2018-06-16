//
//  CouponServices.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase
import Result
import SwiftyStoreKit

private let logger = Log.createLogger()

protocol CreditServiceType {
    func getProducts() -> Observable<[SKProduct]>
    func buyProduct(product: SKProduct) -> Observable<Result<PurchaseDetails, SKError>>
    func setUserCredit(purchasedProduct: PurchaseDetails, user: UserModel) -> Observable<Result<UserCreditModel, FirebaseStoreError>>
    func getCredits() -> Observable<[CreditModel]> 
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func deleteCredit(credit: CreditModel) -> Observable<Bool>
}

class CreditService: CreditServiceType {
    
    private let userService: UserServiceType
    private let purchaseService: PurchaseServiceType
    
    init(userService: UserServiceType, purchaseService: PurchaseServiceType) {
        self.userService = userService
        self.purchaseService = purchaseService
    }
    
    func getProducts() -> Observable<[SKProduct]> {
        return self.getCredits()
            .flatMap { (credits) -> Observable<[SKProduct]> in
                let creditIDs: [String] = credits.compactMap({ $0 })
                    .filter({ $0.id != nil })
                    .map { return $0.id! }
                return self.purchaseService.requestProducts(ids: Set(creditIDs))
        }
    }
    
    func buyProduct(product: SKProduct) -> Observable<Result<PurchaseDetails, SKError>> {
        return purchaseService.purchase(prodcutID: product.productIdentifier)
    }
    
    func setUserCredit(purchasedProduct: PurchaseDetails, user: UserModel) -> Observable<Result<UserCreditModel, FirebaseStoreError>> {
        return self.getCredit(with: purchasedProduct.productId)
            .flatMap { (result) -> Observable<Result<UserCreditModel, FirebaseStoreError>> in
                switch result {
                case .success(let credit):
                    return self.userService.setUserCredit(userId: user.id, numberOfCredits: credit.numberOfCredits!)
                case .failure(let error):
                    logger.log(.error, "error occured when getting credit with id: \(error.localizedDescription)")
                    return .just(.failure(FirebaseStoreError.serializeError))
                }
        }
    }
    
    func getCredit(with id: String) -> Observable<Result<CreditModel, FirebaseFetchError>> {
        return Database.database().reference()
            .child(Constants.credits).child(id).fetch()
    }
    
    func getCredits() -> Observable<[CreditModel]> {
        let credits: Observable<[CreditModel]> = Database.database().reference()
            .child(Constants.credits)
            .fetchArray()
            .recover([])
        return credits
    }
    
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.credits)
            .storeObject(credit)
    }
    
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.credits)
            .update(credit)
    }
    
    func deleteCredit(credit: CreditModel) -> Observable<Bool> {
        return Database.database().reference()
            .child(Constants.credits)
            .deleteWithoutFailure(credit)
    }
}

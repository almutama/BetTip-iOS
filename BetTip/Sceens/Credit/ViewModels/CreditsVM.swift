//
//  CouponVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result
import SwiftyStoreKit

private let logger = Log.createLogger()

protocol CreditsVMType {
    func getProducts() -> Observable<[SKProduct]>
    func buyProduct(product: SKProduct) -> Observable<Result<PurchaseDetails, SKError>> 
    func setUserCredit(purchasedProduct: PurchaseDetails)  -> Observable<Bool>
}

class CreditsVM: BaseViewModel, CreditsVMType {
    
    private let creditService: CreditServiceType!
    private let disposeBag = DisposeBag()
    
    init(creditService: CreditServiceType) {
        self.creditService = creditService
        super.init()
    }
    
    func getProducts() -> Observable<[SKProduct]> {
        return creditService.getProducts()
    }
    
    func buyProduct(product: SKProduct) -> Observable<Result<PurchaseDetails, SKError>> {
        return creditService.buyProduct(product: product)
            .flatMapLatest { purchasedProduct -> Observable<Result<PurchaseDetails, SKError>> in
                switch purchasedProduct {
                case .success(let product):
                    logger.log(.debug, "purchased product was successfull for: \(product.productId)")
                    return Observable.just(.success(product))
                case .failure(let error):
                    logger.log(.debug, "error occured when purchased product: \(error) for \(product.productIdentifier)")
                    return Observable.just(.failure(error))
                }
        }
    }
    
    func setUserCredit(purchasedProduct: PurchaseDetails)  -> Observable<Bool> {
        guard let user =  UserEventService.shared.user.value else {
            return .just(false)
        }
        return creditService.setUserCredit(purchasedProduct: purchasedProduct, user: user)
            .flatMapLatest { result -> Observable<Bool>  in
                switch result {
                case .success(let credit):
                    logger.log(.debug, "set \(credit) credit was successfull for: \(user.id)")
                    return Observable.just(true)
                case .failure(let error):
                    logger.log(.debug, "error occured when set user credit: \(error) for \(user.id)")
                    return Observable.just(false)
                }
        }
    }
}

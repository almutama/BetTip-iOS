//
//  CouponServices.swift
//  BetTip
//
//  Created by Haydar Karkin on 16.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase
import Reactant
import Result

protocol CouponServiceType {
    func getCoupons() -> Observable<[CouponModel]>
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func deleteCredit(credit: CreditModel) -> Observable<Void>
}

class CouponService: CouponServiceType {
    
    private let userService: UserServiceType
    
    init(userService: UserServiceType) {
        self.userService = userService
    }
    
    func getCoupons() -> Observable<[CouponModel]> {
        let credits: Observable<[CouponModel]> = Database.database().reference()
            .child(Constants.coupons)
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
    
    func deleteCredit(credit: CreditModel) -> Observable<Void> {
        return Database.database().reference()
            .child(Constants.credits)
            .delete(credit)
            .rewrite(with: ())
    }
}

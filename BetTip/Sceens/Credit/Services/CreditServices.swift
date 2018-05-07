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

protocol CreditServiceType {
    func getCredits() -> Observable<[CreditModel]>
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func deleteCredit(credit: CreditModel) -> Observable<Bool>
}

class CreditService: CreditServiceType {
    
    private let userService: UserServiceType
    
    init(userService: UserServiceType) {
        self.userService = userService
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

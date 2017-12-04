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
import Reactant
import Result

protocol CreditServiceType {
    func getCredits() -> Observable<[CreditModel]>
}

class CreditService: CreditServiceType {
    
    func getCredits() -> Observable<[CreditModel]> {
        let credits: Observable<[CreditModel]> = Database.database().reference()
            .child(Constants.credits)
            .fetchArray()
            .recover([])
        return credits
    }
}

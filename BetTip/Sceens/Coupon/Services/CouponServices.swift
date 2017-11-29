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

protocol CouponServiceType {
    func getCoupons() -> Observable<[CouponModel]>
}

class CouponService: CouponServiceType {
    
    func getCoupons() -> Observable<[CouponModel]> {
        let coupons: Observable<[CouponModel]> = Database.database().reference()
            .child("coupons")
            .fetchArray()
            .recover([])
        return coupons
    }
}

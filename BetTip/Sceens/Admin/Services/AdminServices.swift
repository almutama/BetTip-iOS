//
//  AdminServices.swift
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

private let logger = Log.createLogger()

protocol AdminServiceType {
    func saveCoupon(coupon: CouponModel, user: UserModel) -> Observable<Result<CouponModel, FirebaseStoreError>>
    func deleteCoupon(coupon: CouponModel, user: UserModel) -> Observable<Void>
}

class AdminService: AdminServiceType {
    
    func saveCoupon(coupon: CouponModel, user: UserModel) -> Observable<Result<CouponModel, FirebaseStoreError>> {
        return Database.database().reference().child("coupons").child(user.id)
            .store(coupon)
    }
    
    func deleteCoupon(coupon: CouponModel, user: UserModel) -> Observable<Void> {
        return Database.database().reference().child("coupons").child(user.id)
            .delete(coupon)
            .rewrite(with: ())
    }
}

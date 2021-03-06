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
import Result

protocol CouponServiceType {
    func getCoupons() -> Observable<[CouponModel]>
    func addCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>>
    func updateCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>>
    func deleteCoupon(coupon: CouponModel) -> Observable<Bool>
    func buyCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>> 
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
    
    func addCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.coupons)
            .storeObject(coupon)
    }
    
    func updateCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.coupons)
            .update(coupon)
    }
    
    func deleteCoupon(coupon: CouponModel) -> Observable<Bool> {
        return Database.database().reference()
            .child(Constants.coupons)
            .deleteWithoutFailure(coupon)
    }
    
    func buyCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>> {
        var mutatingCoupon = coupon
        guard let user = UserEventService.shared.user.value else {
            return .just(.failure(FirebaseStoreError.serializeError))
        }
        guard let userCredit = user.userCredit?.currentCredit else {
            return .just(.failure(FirebaseStoreError.serializeError))
        }
        guard let couponCredit = mutatingCoupon.numOfCredit else {
            return .just(.failure(FirebaseStoreError.serializeError))
        }
        if userCredit < couponCredit {
            let title = L10n.Coupon.notEnoughTitle
            let body = L10n.Coupon.notEnough
            LocalNotificationView.shared.showError(title, body: body)
            return .just(.failure(FirebaseStoreError.serializeError))
        }
        if !mutatingCoupon.users.contains(user.id) {
            mutatingCoupon.users.append(user.id)
        }
        
        return Database.database().reference()
            .child(Constants.coupons)
            .update(mutatingCoupon)
    }
}

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
    func getCredits() -> Observable<[CreditModel]>
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func deleteCredit(credit: CreditModel) -> Observable<Bool>
    func getCoupons() -> Observable<[CouponModel]>
    func addCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>>
    func updateCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>>
    func deleteCoupon(coupon: CouponModel) -> Observable<Bool>
    func getUsers() -> Observable<[UserModel]>
    func changeUserRole(user: UserModel, role: Role) -> Observable<Bool>
    func disableUser(user: UserModel, disabled: Bool) -> Observable<Bool>
}

class AdminService: AdminServiceType {
    
    private let userService: UserServiceType
    private let creditService: CreditServiceType
    private let couponService: CouponServiceType
    
    init(userService: UserServiceType,
         creditService: CreditServiceType,
         couponService: CouponServiceType) {
        self.userService = userService
        self.creditService = creditService
        self.couponService = couponService
    }
    
    func getCredits() -> Observable<[CreditModel]> {
        return creditService.getCredits()
    }
    
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return creditService.addCredit(credit: credit)
    }
    
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return creditService.updateCredit(credit: credit)
    }
    
    func deleteCredit(credit: CreditModel) -> Observable<Bool> {
        return creditService.deleteCredit(credit: credit)
    }
    
    func getCoupons() -> Observable<[CouponModel]> {
        return couponService.getCoupons()
    }
    
    func addCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>> {
        return couponService.addCoupon(coupon: coupon)
    }
    
    func updateCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>> {
        return couponService.updateCoupon(coupon: coupon)
    }
    
    func deleteCoupon(coupon: CouponModel) -> Observable<Bool> {
        return couponService.deleteCoupon(coupon: coupon)
    }
    
    func getUsers() -> Observable<[UserModel]> {
        return self.userService.users()
    }
    
    func changeUserRole(user: UserModel, role: Role) -> Observable<Bool> {
        return userService.setAccountRole(user: user, role: role)
    }
    
    func disableUser(user: UserModel, disabled: Bool) -> Observable<Bool> {
        return userService.setAccountDisabled(user: user, disabled: disabled)
    }
}

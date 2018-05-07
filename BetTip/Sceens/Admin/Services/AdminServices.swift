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
    func addMatch(match: MatchModel) -> Observable<Result<MatchModel, FirebaseStoreError>>
    func basketballMatches() -> Observable<[MatchModel]>
    func footballMatches() -> Observable<[MatchModel]>
}

class AdminService: AdminServiceType {
    
    private let userService: UserServiceType
    private let creditService: CreditServiceType
    private let couponService: CouponServiceType
    private let matchService: MatchServiceType
    
    init(userService: UserServiceType,
         creditService: CreditServiceType,
         couponService: CouponServiceType,
         matchService: MatchServiceType) {
        self.userService = userService
        self.creditService = creditService
        self.couponService = couponService
        self.matchService = matchService
    }
    
    // MARK: Credit Services
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
    
    // MARK: Coupon Services
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
    
    // MARK: User Services
    func getUsers() -> Observable<[UserModel]> {
        return self.userService.users()
    }
    
    func changeUserRole(user: UserModel, role: Role) -> Observable<Bool> {
        return userService.setAccountRole(user: user, role: role)
    }
    
    func disableUser(user: UserModel, disabled: Bool) -> Observable<Bool> {
        return userService.setAccountDisabled(user: user, disabled: disabled)
    }
    
    // MARK: Match Services
    func addMatch(match: MatchModel) -> Observable<Result<MatchModel, FirebaseStoreError>> {
        return matchService.addMatch(match: match)
    }
    
    func basketballMatches() -> Observable<[MatchModel]> {
        return matchService.getMatches(matchType: Constants.basketballType)
    }
    
    func footballMatches() -> Observable<[MatchModel]> {
        return matchService.getMatches(matchType: Constants.footballType)
    }
}

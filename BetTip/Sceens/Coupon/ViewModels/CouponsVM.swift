//
//  CouponVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 16.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol CouponsVMType {
    func getCoupons() -> Observable<[CouponModel]>
    func buyCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>>
    func setUserCredit(coupon: CouponModel) -> Observable<CouponResult>
    func userCredit() -> Observable<Int> 
}

class CouponsVM: BaseViewModel, CouponsVMType {
    
    private let couponService: CouponServiceType!
    private let userService: UserServiceType!
    private let disposeBag = DisposeBag()
    
    init(couponService: CouponServiceType, userService: UserServiceType) {
        self.couponService = couponService
        self.userService = userService
        super.init()
    }
    
    func getCoupons() -> Observable<[CouponModel]> {
        return couponService.getCoupons()
    }

    func buyCoupon(coupon: CouponModel) -> Observable<Result<CouponModel, FirebaseStoreError>> {
        return couponService.buyCoupon(coupon: coupon)
            .flatMap { result -> Observable<Result<CouponModel, FirebaseStoreError>> in
            switch result {
            case .success(let coupon):
                logger.log(.debug, "bought coupon successfull for: \(coupon)")
                return Observable.just(.success(coupon))
            case .failure(let error):
                logger.log(.debug, "error occured when coupon bought: \(error) for \(coupon)")
                return Observable.just(.failure(error))
            }
        }
    }
    
    func setUserCredit(coupon: CouponModel) -> Observable<CouponResult> {
        guard let user = UserEventService.shared.user.value else {
            return Observable.just(CouponResult(result: false, resultAction: .buyCoupon))
        }
        return self.userService.setUserCredit(userId: user.id,
                                              numberOfCredits: coupon.numOfCredit!,
                                              creditAction: .subtrack).flatMapLatest { result -> Observable<CouponResult> in
                                                switch result {
                                                case .success(let userCredit):
                                                    logger.log(.debug, "set user credit successfull for: \(userCredit)")
                                                    return Observable.just(CouponResult(result: true, resultAction: .buyCoupon))
                                                case .failure(let error):
                                                    logger.log(.debug, "error occured when set user credit: \(error) for \(coupon)")
                                                    return Observable.just(CouponResult(result: false, resultAction: .buyCoupon))
                                                }
        }
    }
    
    func userCredit() -> Observable<Int> {
        guard let user = UserEventService.shared.user.value else {
            return Observable.just(0)
        }
        return self.userService.userCredit(userId: user.id).map { $0.value?.currentCredit ?? 0 }
    }
}

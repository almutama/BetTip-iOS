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
    func buyCoupon(coupon: CouponModel) -> Observable<Bool>
}

class CouponsVM: BaseViewModel, CouponsVMType {
    
    private let couponService: CouponServiceType!
    private let disposeBag = DisposeBag()
    
    init(couponService: CouponServiceType) {
        self.couponService = couponService
        super.init()
    }
    
    func getCoupons() -> Observable<[CouponModel]> {
        return couponService.getCoupons()
    }
    
    func buyCoupon(coupon: CouponModel) -> Observable<Bool> {
        return couponService.buyCoupon(coupon: coupon)
            .flatMapLatest { coupon -> Observable<Bool> in
            switch coupon {
            case .success(let coupon):
                logger.log(.debug, "saved coupon is: \(coupon)")
                return Observable.just(true)
            case .failure(let error):
                logger.log(.debug, "error occured when coupon bought: \(error) for \(coupon)")
                return Observable.just(false)
            }
        }
    }
}

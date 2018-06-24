//
//  CouponCellVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 22.06.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol CouponCellVMType {
    func searchUserCoupon(coupon: CouponModel) -> Observable<Bool>
    func getCoupon() -> Observable<CouponModel>
}

class CouponCellVM: BaseViewModel, CouponCellVMType {
    
    private let userService: UserServiceType!
    private let couponModel: CouponModel!
    private let disposeBag = DisposeBag()
    
    init(userService: UserServiceType, couponModel: CouponModel) {
        self.userService = userService
        self.couponModel = couponModel
        super.init()
    }
    
    func searchUserCoupon(coupon: CouponModel) -> Observable<Bool> {
        guard let user = UserEventService.shared.user.value, let couponId = coupon.id else {
            return Observable.just(false)
        }
        return self.userService.isCouponExist(userId: user.id, couponId: couponId)
    }
    
    func getCoupon() -> Observable<CouponModel> {
        return Observable.just(self.couponModel)
    }
}

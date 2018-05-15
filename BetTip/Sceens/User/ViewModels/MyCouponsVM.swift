//
//  MyCouponsVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol MyCouponsVMType {
    func getCoupons() -> Observable<[CouponModel]>
}

class MyCouponsVM: BaseViewModel, MyCouponsVMType {
    
    private let couponService: CouponServiceType!
    private let disposeBag = DisposeBag()
    
    init(couponService: CouponServiceType) {
        self.couponService = couponService
        super.init()
    }
    
    func getCoupons() -> Observable<[CouponModel]> {
        return couponService.getCoupons()
    }
}

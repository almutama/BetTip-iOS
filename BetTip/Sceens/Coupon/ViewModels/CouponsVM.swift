//
//  CouponVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol CouponsVMType {
    
}

class CouponsVM: BaseViewModel, CouponsVMType {
    
    private let couponService: CouponServiceType!
    private let disposeBag = DisposeBag()
    
    init(couponService: CouponServiceType) {
        self.couponService = couponService
        super.init()
    }
}

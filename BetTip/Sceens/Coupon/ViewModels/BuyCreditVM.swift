//
//  BuyCreditVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 2.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol BuyCreditVMType {
    
}

class BuyCreditVM: BaseViewModel, BuyCreditVMType {
    
    private let couponService: CouponServiceType!
    private let disposeBag = DisposeBag()
    
    init(couponService: CouponServiceType) {
        self.couponService = couponService
        super.init()
    }
}

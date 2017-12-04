//
//  CouponVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol CreditsVMType {
    
}

class CreditsVM: BaseViewModel, CreditsVMType {
    
    private let couponService: CreditServiceType!
    private let disposeBag = DisposeBag()
    
    init(couponService: CreditServiceType) {
        self.couponService = couponService
        super.init()
    }
}

//
//  MyCouponDetailVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol MyCouponDetailVMType {
    func getCredits() -> Observable<[CreditModel]>
}

class MyCouponDetailVM: BaseViewModel, MyCouponDetailVMType {
    
    private let creditService: CreditServiceType!
    private let disposeBag = DisposeBag()
    
    init(creditService: CreditServiceType) {
        self.creditService = creditService
        super.init()
    }
    
    func getCredits() -> Observable<[CreditModel]> {
        return creditService.getCredits()
    }
}

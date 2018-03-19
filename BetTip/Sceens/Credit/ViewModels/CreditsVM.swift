//
//  CouponVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol CreditsVMType {
    func getCredits() -> Observable<[CreditModel]>
}

class CreditsVM: BaseViewModel, CreditsVMType {
    
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

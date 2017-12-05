//
//  ControlCreditsVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 5.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol ControlCreditsVMType {
    func getCredits() -> Observable<[CreditModel]>
}

class ControlCreditsVM: BaseViewModel, ControlCreditsVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func getCredits() -> Observable<[CreditModel]> {
        return self.adminService.getCredits()
    }
}

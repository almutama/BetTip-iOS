//
//  AdminVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol AdminVMType {
    func getCredits() -> Observable<[CreditModel]>
    func getUsers() -> Observable<[UserModel]>
}

class AdminVM: BaseViewModel, AdminVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func getCredits() -> Observable<[CreditModel]> {
        return self.adminService.getCredits()
    }
    
    func getUsers() -> Observable<[UserModel]> {
        return self.adminService.getUsers()
    }
}

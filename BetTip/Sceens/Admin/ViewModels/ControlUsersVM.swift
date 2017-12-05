//
//  ControlUsersVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 5.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol ControlUsersVMType {
    func getUsers() -> Observable<[UserModel]>
}

class ControlUsersVM: BaseViewModel, ControlUsersVMType {
    
    private let adminService: AdminServiceType!
    private let disposeBag = DisposeBag()
    
    init(adminService: AdminServiceType) {
        self.adminService = adminService
        super.init()
    }
    
    func getUsers() -> Observable<[UserModel]> {
        return self.adminService.getUsers()
    }
}

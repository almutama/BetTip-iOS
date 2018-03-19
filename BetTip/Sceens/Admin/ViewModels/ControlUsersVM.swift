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
    func changeUserRole(user: UserModel, role: Role) -> Observable<Bool>
    func disableUser(user: UserModel, disabled: Bool) -> Observable<Bool>
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
    
    func changeUserRole(user: UserModel, role: Role) -> Observable<Bool> {
        return self.adminService
            .changeUserRole(user: user, role: role)
            .trackActivity(loadingIndicator)
            .map { value in return value }
            .catchErrorJustReturn(false)
    }
    
    func disableUser(user: UserModel, disabled: Bool) -> Observable<Bool> {
        return self.adminService
            .disableUser(user: user, disabled: disabled)
            .trackActivity(loadingIndicator)
            .map { value in return value }
            .catchErrorJustReturn(false)
    }
}

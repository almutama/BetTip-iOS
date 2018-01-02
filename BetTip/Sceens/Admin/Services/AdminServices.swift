//
//  AdminServices.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase
import Reactant
import Result

private let logger = Log.createLogger()

protocol AdminServiceType {
    func getCredits() -> Observable<[CreditModel]>
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func deleteCredit(credit: CreditModel) -> Observable<Bool>
    func getUsers() -> Observable<[UserModel]>
    func changeUserRole(user: UserModel, role: Role) -> Observable<Bool>
    func disableUser(user: UserModel, disabled: Bool) -> Observable<Bool>
}

class AdminService: AdminServiceType {
    
    private let userService: UserServiceType
    private let creditService: CreditServiceType
    
    init(userService: UserServiceType, creditService: CreditServiceType) {
        self.userService = userService
        self.creditService = creditService
    }
    
    func getCredits() -> Observable<[CreditModel]> {
        return creditService.getCredits()
    }
    
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return creditService.addCredit(credit: credit)
    }
    
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return creditService.updateCredit(credit: credit)
    }
    
    func deleteCredit(credit: CreditModel) -> Observable<Bool> {
        return creditService.deleteCredit(credit: credit)
    }
    
    func getUsers() -> Observable<[UserModel]> {
        return self.userService.users()
    }
    
    func changeUserRole(user: UserModel, role: Role) -> Observable<Bool> {
        return userService.setAccountRole(user: user, role: role)
    }
    
    func disableUser(user: UserModel, disabled: Bool) -> Observable<Bool> {
        return userService.setAccountDisabled(user: user, disabled: disabled)
    }
}

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
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func deleteCredit(credit: CreditModel) -> Observable<Void>
}

class AdminService: AdminServiceType {
    
    private let userService: UserServiceType
    private let creditService: CreditServiceType
    
    init(userService: UserServiceType, creditService: CreditServiceType) {
        self.userService = userService
        self.creditService = creditService
    }
    
    func addCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return creditService.addCredit(credit: credit)
    }
    
    func updateCredit(credit: CreditModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return creditService.updateCredit(credit: credit)
    }
    
    func deleteCredit(credit: CreditModel) -> Observable<Void> {
        return creditService.deleteCredit(credit: credit)
    }
}

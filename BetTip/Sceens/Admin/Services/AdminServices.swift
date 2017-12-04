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
    func saveCredit(coupon: CreditModel, user: UserModel) -> Observable<Result<CreditModel, FirebaseStoreError>>
    func deleteCredit(coupon: CreditModel, user: UserModel) -> Observable<Void>
}

class AdminService: AdminServiceType {
    
    func saveCredit(coupon: CreditModel, user: UserModel) -> Observable<Result<CreditModel, FirebaseStoreError>> {
        return Database.database().reference().child(Constants.credits).child(user.id)
            .storeObject(coupon)
    }
    
    func deleteCredit(coupon: CreditModel, user: UserModel) -> Observable<Void> {
        return Database.database().reference().child(Constants.credits).child(user.id)
            .delete(coupon)
            .rewrite(with: ())
    }
}

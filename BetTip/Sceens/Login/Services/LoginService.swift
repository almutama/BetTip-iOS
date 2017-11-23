//
//  LoginService.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

protocol LoginServiceType {
    func createUserWith(email: String, password: String) -> Single<User>
    func signInWith(email: String, password: String) -> Single<User>
    func signOut() -> Completable
}

class LoginService {
}

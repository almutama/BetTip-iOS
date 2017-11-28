//
//  AuthProvider.swift
//  BetTip
//
//  Created by Haydar Karkin on 25.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import SwiftKeychainWrapper
import Reactant
import Result

class AuthProvider: AuthProviderType {
    
    private static let emailKey = "email"
    private static let passwordKey = "password"
    
    static let key: String = "credential"
    
    private let authStore: AuthStoreType
    private let loginService: LoginServiceType
    
    init(authStore: AuthStoreType, loginService: LoginServiceType) {
        self.authStore = authStore
        self.loginService = loginService
    }
    
    func login(email: String, password: String) -> Observable<Result<UserModel, FirebaseLoginError>> {
        return loginService.login(email: email, password: password)
            .take(1)
            .do(onNext: {
                guard let value = $0.value else { return }
                self.authStore.authorize(with: value)
                self.saveState(email: email, password: password)
            })
    }
    
    func register(email: String, password: String) -> Observable<Result<UserModel, FirebaseSignupError>> {
        return loginService.register(email: email, password: password)
            .take(1)
            .do(onNext: {
                guard let value = $0.value else { return }
                self.authStore.authorize(with: value)
                self.saveState(email: email, password: password)
            })
    }
    
    func resetPassword(email: String) -> Observable<Result<Void, FirebaseLoginError>> {
        return loginService.resetPassword(email: email).take(1)
    }
    
    func saveState(email: String, password: String) {
        activate()
        
        KeychainWrapper.standard.set(email, forKey: AuthProvider.emailKey)
        KeychainWrapper.standard.set(password, forKey: AuthProvider.passwordKey)
    }
    
    func restoreState(profile: UserModel?)
        -> Observable<Result<UserModel, AuthenticationError>> {
            if let
                email = KeychainWrapper.standard.string(forKey: AuthProvider.emailKey),
                let password = KeychainWrapper.standard.string(forKey: AuthProvider.passwordKey) {
                return login(email: email, password: password).mapError(AuthenticationError.firebaseError)
            } else {
                deactivate()
                #if DEBUG
                    fatalError("Credentials are not stored before restore is called!!!")
                #else
                    return Observable.just(.Failure(.Unknown))
                #endif
            }
    }
    
    func deleteState() -> Observable<Result<Void, DeauthenticationError>> {
        KeychainWrapper.standard.removeObject(forKey: AuthProvider.emailKey)
        KeychainWrapper.standard.removeObject(forKey: AuthProvider.passwordKey)
        
        return loginService.logout().mapError(DeauthenticationError.firebaseError)
    }
}

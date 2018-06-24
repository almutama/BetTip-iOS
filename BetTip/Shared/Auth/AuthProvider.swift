//
//  AuthProvider.swift
//  BetTip
//
//  Created by Haydar Karkin on 25.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import SwiftKeychainWrapper
import Result

private let logger = Log.createLogger()

protocol AuthProviderType {
    static var key: String { get }
    var active: Bool { get }
    
    func restoreState(profile: UserModel?) -> Observable<Result<UserModel, AuthenticationError>>
    func deleteState() -> Observable<Result<Void, DeauthenticationError>>
    
    func activate()
    func deactivate()
    
    func login(email: String, password: String) -> Observable<Result<UserModel, FirebaseLoginError>>
    func register(email: String, password: String) -> Observable<Result<UserModel, FirebaseSignupError>>
    func resetPassword(email: String) -> Observable<Result<Void, FirebaseLoginError>>
}

extension AuthProviderType {
    var active: Bool {
        return KeychainWrapper.standard.string(forKey: Constants.activeAuthProviderKey) == Self.key
    }
    
    func activate() {
        KeychainWrapper.standard.set(Self.key, forKey: Constants.activeAuthProviderKey)
    }
    
    func deactivate() {
        KeychainWrapper.standard.removeObject(forKey: Constants.activeAuthProviderKey)
    }
}

class AuthProvider: AuthProviderType {
    
    static let key: String = Constants.credentialKey
    
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
        
        KeychainWrapper.standard.set(email, forKey: Constants.emailKey)
        KeychainWrapper.standard.set(password, forKey: Constants.passwordKey)
    }
    
    func restoreState(profile: UserModel?)
        -> Observable<Result<UserModel, AuthenticationError>> {
            if
                let email = KeychainWrapper.standard.string(forKey: Constants.emailKey),
                let password = KeychainWrapper.standard.string(forKey: Constants.passwordKey) {
                return login(email: email, password: password).mapError(AuthenticationError.firebaseError)
            } else {
                logger.log(.error, "Credentials are not stored before restore is called!!!")
                self.deactivate()                
                return Observable.just(.failure(.unknown))
            }
    }
    
    func deleteState() -> Observable<Result<Void, DeauthenticationError>> {
        KeychainWrapper.standard.removeObject(forKey: Constants.emailKey)
        KeychainWrapper.standard.removeObject(forKey: Constants.passwordKey)
        
        return loginService.logout().mapError(DeauthenticationError.firebaseError)
    }
}

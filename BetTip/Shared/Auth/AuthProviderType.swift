//
//  AuthProvider.swift
//  BetTip
//
//  Created by Haydar Karkin on 25.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Reactant
import Result
import SwiftKeychainWrapper

private let passwordKey = "password"
private let authTypeKey = "authType"
private let activeAuthProviderKey = "activeAuthProvider"

typealias DeviceToken = String

enum Authorization {
    case authenticated(UserModel)
    case unauthenticated
    
    var authorized: Bool {
        switch self {
        case .authenticated:
            return true
        case .unauthenticated:
            return false
        }
    }
    
    var email: String? {
        switch self {
        case .authenticated(let user):
            return user.email
        case .unauthenticated:
            return nil
        }
    }
}

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
        return KeychainWrapper.standard.string(forKey: activeAuthProviderKey) == Self.key
    }
    
    func activate() {
        KeychainWrapper.standard.set(Self.key, forKey: activeAuthProviderKey)
    }
    
    func deactivate() {
        KeychainWrapper.standard.removeObject(forKey: activeAuthProviderKey)
    }
}

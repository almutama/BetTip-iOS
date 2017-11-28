//
//  AuthStore.swift
//  BetTip
//
//  Created by Haydar Karkin on 25.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import SwiftKeychainWrapper
import ObjectMapper
import Reactant

protocol AuthStoreType {
    func authorize(with profile: UserModel)
    func deauthorize()
    func storedProfile() -> UserModel?
}

class AuthStore: AuthStoreType {
    
    init() {}
    
    private static let profileKey = "AuthStore.Profile"
    
    var authorization: Observable<Authorization> {
        return authorizationSubject
    }
    
    private let authorizationSubject: BehaviorSubject<Authorization> = BehaviorSubject(value: .unauthenticated)
    
    func authorize(with profile: UserModel) {
        storeProfile(profile: profile)
        authorizationSubject.onNext(.authenticated(profile))
    }
    
    func deauthorize() {
        deleteUserInfo()
        authorizationSubject.onNext(.unauthenticated)
    }
    
    func storedProfile() -> UserModel? {
        if let jsonData = KeychainWrapper.standard.string(forKey: AuthStore.profileKey) {
            return Mapper<UserModel>().map(JSONObject: jsonData)
        } else {
            return nil
        }
    }
    
    private func storeProfile(profile: UserModel) {
        if let jsonData = Mapper<UserModel>().toJSONString(profile) {
            KeychainWrapper.standard.set(jsonData, forKey: AuthStore.profileKey)
        }
    }
    
    private func deleteUserInfo() {
        KeychainWrapper.standard.removeObject(forKey: AuthStore.profileKey)
    }
}

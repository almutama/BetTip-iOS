//
//  AuthManager.swift
//  BetTip
//
//  Created by Haydar Karkin on 25.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Reactant
import Result

final class AuthManager {
    
    var activeProvider: AuthProvider? {
        for provider in providers.values where provider.active {
            return provider
        }
        return nil
    }
    let authStore: AuthStore
    
    private let providers: [String: AuthProvider]
    
    init(authStore: AuthStore, providers: [AuthProvider]) {
        self.authStore = authStore
        
        var providerDictionary: [String: AuthProvider] = [:]
        for provider in providers {
            providerDictionary[type(of: provider).key] = provider
        }
        self.providers = providerDictionary
    }
    
    func restoreState() -> Observable<Result<UserModel, AuthenticationError>> {
        let userInfo = authStore.storedProfile()
        return activeProvider?.restoreState(profile: userInfo) ?? Observable.just(.failure(.unknown))
    }
    
    func logout() -> Observable<Result<Void, DeauthenticationError>> {
        return (activeProvider?.deleteState() ?? Observable.just(.success(()))).do(onNext: { [weak self] in
            if case .success = $0 {
                self?.activeProvider?.deactivate()
                self?.authStore.deauthorize()
            }
        })
    }
}

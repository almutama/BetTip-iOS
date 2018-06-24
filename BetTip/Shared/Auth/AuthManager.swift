//
//  AuthManager.swift
//  BetTip
//
//  Created by Haydar Karkin on 25.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Result

protocol AuthManagerType {
    func restoreState() -> Observable<Result<UserModel, AuthenticationError>>
    func logout() -> Observable<Result<Void, DeauthenticationError>>
}

class AuthManager: AuthManagerType {
    
    private let authStore: AuthStoreType
    private let authProvider: AuthProviderType
    
    init(authStore: AuthStoreType, authProvider: AuthProviderType) {
        self.authStore = authStore
        self.authProvider = authProvider
    }
    
    func restoreState() -> Observable<Result<UserModel, AuthenticationError>> {
        let userInfo = authStore.storedProfile()
        return authProvider.restoreState(profile: userInfo)
    }
    
    func logout() -> Observable<Result<Void, DeauthenticationError>> {
        return (authProvider.deleteState() ).do(onNext: { [weak self] in
            if case .success = $0 {
                self?.authProvider.deactivate()
                self?.authStore.deauthorize()
            }
        })
    }
}

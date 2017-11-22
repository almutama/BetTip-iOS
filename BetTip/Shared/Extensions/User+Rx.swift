//
//  User+Rx.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import FirebaseAuth
import RxSwift

extension Reactive where Base: User {
    func link(with credential: AuthCredential) -> Single<User> {
        return .create { [weak user = self.base] observer in
            user?.link(with: credential) { authUser, error in
                switch Result(authUser, error) {
                case .success(let user):
                    observer(.success(user))
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func unlink(with provider: String) -> Single<User> {
        return .create { [weak user = self.base] observer in
            user?.unlink(fromProvider: provider) { authUser, error in
                switch Result(authUser, error) {
                case .success(let user):
                    observer(.success(user))
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func reload() -> Single<Void> {
        return .create { [weak user = self.base] observer in
            user?.reload { error in
                if let error = error {
                    observer(.error(error))
                    return
                }
                observer(.success(()))
            }
            return Disposables.create()
        }
    }
}

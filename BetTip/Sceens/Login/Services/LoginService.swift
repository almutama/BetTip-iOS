//
//  LoginService.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import Reactant
import Result

protocol LoginServiceType {
    func login(email: String, password: String) -> Observable<Result<UserModel, FirebaseLoginError>>
    func logout() -> Observable<Result<Void, FirebaseCommonError>>
    func register(email: String, password: String) -> Observable<Result<UserModel, FirebaseSignupError>>
    func resetPassword(email: String) -> Observable<Result<Void, FirebaseLoginError>>
}

class LoginService: LoginServiceType {
    
    private let userService: UserServiceType
    
    init(userService: UserServiceType) {
        self.userService = userService
    }
    
    func login(email: String, password: String) -> Observable<Result<UserModel, FirebaseLoginError>> {
        return Observable<Result<User, FirebaseLoginError>>
            .create { observer in
                Auth.auth().signIn(withEmail: email, password: password) { user, error in
                    if let user = user {
                        observer.onLast(.success(user))
                    } else if let error = error {
                        observer.onLast(.failure(FirebaseLoginError(error: error as NSError)))
                    } else {
                        observer.onLast(.failure(.common(.unknown)))
                    }
                }
                return Disposables.create()
            }
            .flatMapLatest { [userService] login -> Observable<Result<User, FirebaseLoginError>> in
                switch login {
                case .success(let user):
                    return userService.userDisabled(userId: user.uid)
                        .take(1)
                        .map { $0 ? .failure(.userDisabled) : .success(user) }
                case .failure(let error):
                    return .just(.failure(error))
                }
            }
            .flatMapLatest { [userService] login -> Observable<Result<UserModel, FirebaseLoginError>> in
                switch login {
                case .success(let user):
                    return userService.userProfile(userId: user.uid).mapError { _ in .common(.internalError) }
                case .failure(let error):
                    return .just(.failure(error))
                }
        }
    }
    
    func logout() -> Observable<Result<Void, FirebaseCommonError>> {
        do {
            try Auth.auth().signOut()
            return .just(.success(()))
        } catch {
            let firebaseError = FirebaseCommonError(error: error as NSError)
            return .just(.failure(firebaseError))
        }
    }
    
    func register(email: String, password: String) -> Observable<Result<UserModel, FirebaseSignupError>> {
        return Observable<Result<UserModel, FirebaseSignupError>>.create { observer in
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if let user = user {
                    let profile = UserModel(user: user)
                    observer.onLast(.success(profile))
                } else if let error = error {
                    observer.onLast(.failure(FirebaseSignupError(error: error as NSError)))
                } else {
                    observer.onLast(.failure(.common(.unknown)))
                }
            }
            return Disposables.create()
            }.flatMapLatest { registration -> Observable<Result<UserModel, FirebaseSignupError>> in
                switch registration {
                case .success(let profile):
                    return Database.database().reference()
                        .child(Constants.users)
                        .storeWithKey(profile, forKey: profile.id)
                        .mapValue { $0.object }
                        .mapError { _ in .common(.internalError) }
                case .failure(let error):
                    return .just(.failure(error))
                }
        }
    }
    
    func resetPassword(email: String) -> Observable<Result<Void, FirebaseLoginError>> {
        return Observable<Result<Void, FirebaseLoginError>>
            .create { observer in
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        observer.onLast(.failure(FirebaseLoginError(error: error as NSError)))
                    } else {
                        observer.onLast(.success(()))
                    }
                }
                return Disposables.create()
            }
    }
}

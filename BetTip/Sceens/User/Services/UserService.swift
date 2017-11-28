//
//  UserService.swift
//  BetTip
//
//  Created by Haydar Karkin on 24.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase
import Reactant
import Result

protocol UserServiceType {
    func users() -> Observable<[UserModel]>
    func userProfile(userId: String) -> Observable<Result<UserModel, FirebaseFetchError>>
    func userDisabled(userId: String) -> Observable<Bool>
}

class UserService: UserServiceType {
    
    func addOrReplaceUser(accumulator: [UserModel], user: UserModel) -> [UserModel] {
        var resultantArray = accumulator.filter { $0.id != user.id }
        resultantArray.append(user)
        return resultantArray
    }
    
    func users() -> Observable<[UserModel]> {
        let userList: Observable<[UserModel]> = Database.database().reference()
            .child("users")
            .fetchArray()
            .recover([])
        
        let unsortedResult = userList.flatMapLatest { users in
            Observable.from(users)
                .flatMap(self.setProfileProperties)
                .scan([], accumulator: self.addOrReplaceUser)
                .filter { $0.count == users.count }
        }
        
        return unsortedResult.map { $0.sorted { $0.email! < $1.email! } }
    }
    
    func userRole(userId: String) -> Observable<Role> {
        let ref = Database.database().reference()
        
        return Observable.combineLatest(
            ref.child("moderators").child(userId).exists(),
            ref.child("admins").child(userId).exists()) { isModerator, isAdmin in
                isAdmin ? .admin : isModerator ? .moderator : .user
        }
    }
    
    func userDisabled(userId: String) -> Observable<Bool> {
        return Database.database().reference()
            .child("disabledUsers")
            .child(userId)
            .exists()
    }
    
    func userProfile(userId: String) -> Observable<Result<UserModel, FirebaseFetchError>> {
        let user = Database.database().reference()
            .child("users")
            .child(userId)
            .fetch(UserModel.self)
        
        return user.flatMapLatest { user -> Observable<Result<UserModel, FirebaseFetchError>> in
            switch user {
            case .success(let profile):
                return self.setProfileProperties(user: profile).map { .success($0) }
            case .failure(let error):
                return .just(.failure(error))
            }
        }
    }
    
    func setAccountDisabled(user: UserModel, disabled: Bool) -> Observable<Bool> {
        let path = Database.database().reference().child("disabledUsers").child(user.id)
        
        return Observable.create { observer in
            if disabled {
                path.setValue(true) { error, _ in
                    observer.onLast(error == nil)
                }
            } else {
                path.removeValue { error, _ in
                    observer.onLast(error == nil)
                }
            }
            return Disposables.create()
        }
    }
    
    func setAccountRole(user: UserModel, role: Role) -> Observable<Bool> {
        guard user.role != role else { return .just(false) }
        
        return Observable.create { observer in
            let ref = Database.database().reference()
            
            let removalCompletion: (Error?, DatabaseReference) -> Void = { error, _ in
                observer.onLast(error == nil)
            }
            let addCompletion: (Error?, DatabaseReference) -> Void = { error, _ in
                guard error == nil else {
                    observer.onLast(false)
                    return
                }
                
                switch user.role {
                case .admin:
                    ref.child("admins").child(user.id).removeValue(completionBlock: removalCompletion)
                case .moderator:
                    ref.child("moderators").child(user.id).removeValue(completionBlock: removalCompletion)
                case .user:
                    removalCompletion(nil, ref)
                }
            }
            
            switch role {
            case .admin:
                ref.child("admins").child(user.id).setValue(true, withCompletionBlock: addCompletion)
            case .moderator:
                ref.child("moderators").child(user.id).setValue(true, withCompletionBlock: addCompletion)
            case .user:
                addCompletion(nil, ref)
            }
            
            return Disposables.create()
        }
    }
    
    private func setProfileProperties(user: UserModel) -> Observable<UserModel> {
        let role = self.userRole(userId: user.id)
        let disabled = self.userDisabled(userId: user.id)
        return Observable.combineLatest(role, disabled) { role, disabled in
            var mutableUser = user
            mutableUser.role = role
            mutableUser.disabled = disabled
            return mutableUser
        }
    }
}

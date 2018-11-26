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
import Result

private let logger = Log.createLogger()

protocol UserServiceType {
    func `init`()
    func users() -> Observable<[UserModel]>
    func userProfile(userId: String) -> Observable<Result<UserModel, FirebaseFetchError>>
    func userDisabled(userId: String) -> Observable<Bool>
    func userCredit(userId: String) -> Observable<Result<UserCreditModel, FirebaseFetchError>>
    func userCoupons(userId: String) -> Observable<[CouponModel]>
    func isCouponExist(userId: String, couponId: String) -> Observable<Bool> 
    func setAccountDisabled(user: UserModel, disabled: Bool) -> Observable<Bool>
    func setAccountRole(user: UserModel, role: Role) -> Observable<Bool>
    func setUserCreditFirstTime(userId: String) -> Observable<Result<UserCreditModel, FirebaseStoreError>>
    func setUserCredit(userId: String, numberOfCredits: Int, creditAction: UserCreditAction) -> Observable<Result<UserCreditModel, FirebaseStoreError>>
}

class UserService: UserServiceType {
    
    func `init`() {}
    
    func addOrReplaceUser(accumulator: [UserModel], user: UserModel) -> [UserModel] {
        var resultantArray = accumulator.filter { $0.id != user.id }
        resultantArray.append(user)
        return resultantArray
    }
    
    func users() -> Observable<[UserModel]> {
        let userList: Observable<[UserModel]> = Database.database().reference()
            .child(Constants.users)
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
            ref.child(Constants.moderators).child(userId).exists(),
            ref.child(Constants.admins).child(userId).exists()) { isModerator, isAdmin in
                isAdmin ? .admin : isModerator ? .moderator : .user
        }
    }
    
    func userDisabled(userId: String) -> Observable<Bool> {
        return Database.database().reference()
            .child(Constants.disabledUsers)
            .child(userId)
            .exists()
    }
    
    func userCredit(userId: String) -> Observable<Result<UserCreditModel, FirebaseFetchError>> {
        return Database.database().reference()
            .child(Constants.userCredits)
            .child(userId)
            .fetch(UserCreditModel.self)
    }
    
    func userCoupons(userId: String) -> Observable<[CouponModel]> {
        let coupons: Observable<[CouponModel]> = Database.database().reference()
            .child(Constants.coupons)
            .fetchArray()
            .recover([])
        
        return coupons.asObservable().map({ coupons in
            coupons.filter { $0.users.contains(userId) }
        })
    }
    
    func isCouponExist(userId: String, couponId: String) -> Observable<Bool> {
        return Database.database().reference()
            .child(Constants.userCoupons)
            .child(userId)
            .child(couponId)
            .exists()
    }
    
    func setUserCreditFirstTime(userId: String) -> Observable<Result<UserCreditModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.userCredits)
            .storeWithKey(UserCreditModel(id: userId, currentCredit: 0, usedCredit: 0), forKey: userId)
            .mapValue { $0 }
            .mapError { error in .writeDenied(error) }
    }
    
    func setUserCredit(userId: String, numberOfCredits: Int, creditAction: UserCreditAction) -> Observable<Result<UserCreditModel, FirebaseStoreError>> {
        return self.userCredit(userId: userId)
            .flatMapFirst { credit -> Observable<Result<UserCreditModel, FirebaseStoreError>> in
                switch credit {
                case .success(let userCredit):
                    guard let numOfCredit = userCredit.currentCredit,
                        let usedCredit = userCredit.usedCredit else {
                        return .just(.failure(FirebaseStoreError.serializeError))
                    }
                    let updatedCredit = creditAction == .append ? numOfCredit+numberOfCredits : numOfCredit-numberOfCredits
                    let updatedUsedCredit = creditAction == .append ? usedCredit : usedCredit+numberOfCredits
                    return Database.database().reference()
                        .child(Constants.userCredits)
                        .update(UserCreditModel(id: userId,
                                                currentCredit: updatedCredit,
                                                usedCredit: updatedUsedCredit))
                case .failure(let error):
                    return .just(.failure(FirebaseStoreError.writeDenied(error)))
                }
        }
    }
    
    func userProfile(userId: String) -> Observable<Result<UserModel, FirebaseFetchError>> {
        let user = Database.database().reference()
            .child(Constants.users)
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
        let path = Database.database().reference().child(Constants.disabledUsers).child(user.id)
        
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
                    ref.child(Constants.admins).child(user.id).removeValue(completionBlock: removalCompletion)
                case .moderator:
                    ref.child(Constants.moderators).child(user.id).removeValue(completionBlock: removalCompletion)
                case .user:
                    removalCompletion(nil, ref)
                }
            }
            
            switch role {
            case .admin:
                ref.child(Constants.admins).child(user.id).setValue(true, withCompletionBlock: addCompletion)
            case .moderator:
                ref.child(Constants.moderators).child(user.id).setValue(true, withCompletionBlock: addCompletion)
            case .user:
                addCompletion(nil, ref)
            }
            
            return Disposables.create()
        }
    }
    
    private func setProfileProperties(user: UserModel) -> Observable<UserModel> {
        let role = self.userRole(userId: user.id)
        let disabled = self.userDisabled(userId: user.id)
        let userCredit = self.userCredit(userId: user.id)
        
        return userCredit.flatMapLatest { userCredit -> Observable<UserModel> in
            switch userCredit {
            case .success(let credit):
                return Observable.combineLatest(role, disabled) { role, disabled in
                    var mutableUser = user
                    mutableUser.role = role
                    mutableUser.disabled = disabled
                    mutableUser.userCredit = credit
                    logger.log(.debug, "user info: \(mutableUser.toJSON())")
                    return mutableUser
                }
            case .failure(let error):
                logger.log(.warning, "Error ocurred while getting user credit: \(error)")
                return Observable.combineLatest(role, disabled) { role, disabled in
                    var mutableUser = user
                    mutableUser.role = role
                    mutableUser.disabled = disabled
                    logger.log(.debug, "user info: \(mutableUser.toJSON())")
                    return mutableUser
                }
            }
        }
    }
}

//
//  UserVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

private let logger = Log.createLogger()

protocol UserVMType {
    func getUser() -> Variable<UserModel?>
    func logout(initComplete: @escaping (Bool) -> Void)
    func userCredit() -> Observable<(Int, Int)>
}

class UserVM: BaseViewModel, UserVMType {
    
    private let authStore: AuthStoreType!
    private let authManager: AuthManagerType!
    private let userService: UserServiceType!
    
    var userModel = Variable<UserModel?>(nil)
    let disposeBag = DisposeBag()
    
    init(authStore: AuthStoreType,
         authManager: AuthManagerType,
         userService: UserServiceType) {
        self.authStore = authStore
        self.authManager = authManager
        self.userService = userService
    }
    
    func getUser() -> Variable<UserModel?> {
        return UserEventService.shared.user
    }
    
    func logout(initComplete: @escaping (Bool) -> Void) {
        self.authManager.logout()
            .delaySubscription(0, scheduler: MainScheduler.instance)
            .map { $0.value }
            .subscribe { event in
                switch event {
                case .next(let value):
                    logger.log(.info, "Success when logout: \(String(describing: value))")
                    initComplete(true)
                case .error(let error):
                    logger.log(.error, "Error occured when logout: \(error)")
                    initComplete(false)
                case .completed:
                    logger.log(.debug, "Logout completed!")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func userCredit() -> Observable<(Int, Int)> {
        guard let user = UserEventService.shared.user.value else {
            return Observable.just((0, 0))
        }
        return self.userService.userCredit(userId: user.id).map { ($0.value?.currentCredit ?? 0, $0.value?.usedCredit ?? 0) }
    }
}

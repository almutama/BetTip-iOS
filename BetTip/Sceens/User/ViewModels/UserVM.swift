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

class UserVM: BaseViewModel {
    
    private let authStore: AuthStoreType
    private let authManager: AuthManagerType
    var userModel = Variable<UserModel?>(nil)
    let disposeBag = DisposeBag()
    
    init(authStore: AuthStoreType,
         authManager: AuthManagerType) {
        self.authStore = authStore
        self.authManager = authManager
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
}

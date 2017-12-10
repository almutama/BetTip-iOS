//
//  SplashVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

private let logger = Log.createLogger()

protocol SplashVMType {
    func checkAuth(initComplete: @escaping (UserModel?) -> Void)
}

class SplashVM: BaseViewModel, SplashVMType {
    
    private let authManager: AuthManagerType!
    private let disposeBag = DisposeBag()
    
    init(authManager: AuthManagerType) {
        self.authManager = authManager
        super.init()
    }
    
    func checkAuth(initComplete: @escaping (UserModel?) -> Void) {
        self.authManager.restoreState()
            .delaySubscription(0, scheduler: MainScheduler.instance)
            .map { $0.value }
            .subscribe { event in
                switch event {
                case .next(let value):
                    initComplete(value)
                case .error(let error):
                    logger.log(.error, "Error occured when cheking auth: \(error)")
                case .completed:
                    logger.log(.debug, "Checking auth completed!")
                }
            }
            .disposed(by: disposeBag)
    }
}

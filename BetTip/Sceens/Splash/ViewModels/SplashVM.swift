//
//  SplashVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

class SplashVM: BaseViewModel {
    
    private let authManager: AuthManagerType!
    private let disposeBag = DisposeBag()
    var userModel = Variable<UserModel?>(nil)
    
    init(authManager: AuthManagerType) {
        self.authManager = authManager
        super.init()
    }
    
    func checkAuth() {
        self.authManager.restoreState()
            .delaySubscription(0, scheduler: MainScheduler.instance)
            .map { $0.value }
            .subscribe(onNext: self.sendUser)
            .disposed(by: disposeBag)
    }
    
    func sendUser(_ userModel: UserModel?) {
        self.userModel.value = userModel
    }
}

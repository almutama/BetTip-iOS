//
//  ForgotPasswordVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 26.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol ForgotPasswordVMType {
    
}

class ForgotPasswordVM: BaseViewModel, ForgotPasswordVMType {
    
    let authProvider: AuthProviderType!
    let disposeBag = DisposeBag()
    var isMailSendSuccess = Variable<Bool>(false)
    
    init(authProvider: AuthProviderType) {
        self.authProvider = authProvider
        super.init()
    }
}

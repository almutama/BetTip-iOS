//
//  BasketballVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

class BasketballVM: BaseViewModel {
    
    private let authManager: AuthManagerType!
    private let disposeBag = DisposeBag()
    
    init(authManager: AuthManagerType) {
        self.authManager = authManager
        super.init()
    }
}

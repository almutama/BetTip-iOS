//
//  UserVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

class UserVM: BaseViewModel {
    
    private let authStore: AuthStoreType
    var userModel = Variable<UserModel?>(nil)
    let disposeBag = DisposeBag()
    
    init(authStore: AuthStoreType) {
        self.authStore = authStore
    }
    
    func getUser() {
        self.userModel.value = self.authStore.storedProfile()
    }
}

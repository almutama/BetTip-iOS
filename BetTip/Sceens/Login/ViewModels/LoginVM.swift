//
//  LoginVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

class LoginVM: BaseViewModel {
    
    let credentialAuthProvider: CredentialAuthProvider!
    let disposeBag = DisposeBag()
    var isLoginSuccess = Variable<Bool>(false)
    
    init(credentialAuthProvider: CredentialAuthProvider) {
        self.credentialAuthProvider = credentialAuthProvider
        super.init()
    }
    
    func login(email: String, password: String) {
        let validatedCredentials = loginCredentialsRule.run((email: email, password: password))
        
        switch validatedCredentials {
        case .success(let email, let password):
            print("")
            let login = self.credentialAuthProvider.login(email: email, password: password)
                .trackActivity(in: loadingIndicator)
                .share(replay: 1)
            
            login.filterError()
                .subscribe(onNext: self.loginSuccessful)
                .disposed(by: disposeBag)
            
        case .failure(let error):
            print(error)
        }
    }
    
    func loginSuccessful (user: UserModel) {
        self.isLoginSuccess.value = true
    }
}

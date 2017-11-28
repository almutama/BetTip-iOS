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
    
    let authProvider: AuthProviderType!
    let disposeBag = DisposeBag()
    var isLoginSuccess = Variable<Bool>(false)
    
    init(authProvider: AuthProviderType) {
        self.authProvider = authProvider
        super.init()
    }
    
    func login(email: String, password: String) {
        let validatedCredentials = loginCredentialsRule.run((email: email, password: password))
        
        switch validatedCredentials {
        case .success(let email, let password):
            print("")
            let login = self.authProvider.login(email: email, password: password)
                .trackActivity(in: loadingIndicator)
                .share(replay: 1)
            
            login.filterError()
                .subscribe(onNext: self.loginSuccessful)
                .disposed(by: disposeBag)
            
            login.errorOnly()
                .map { error in
                    switch error {
                    case .wrongPassword, .common(.userNotFound):
                        return L10n.Auth.Error.wrongPassword
                    case .userDisabled:
                        return L10n.Auth.Error.userDisabled
                    default:
                        return L10n.Auth.Error.unknown
                    }
                }
                .subscribe(onNext: {
                    LocalNotificationView.shared.showError(L10n.Auth.Error.loginTitle, body: $0)
                })
                .disposed(by: disposeBag)
            
        case .failure(let error):
            let errorMessage: String
            switch error {
            case .emailInvalid(.empty):
                errorMessage = L10n.Auth.Error.emptyEmail
            case .emailInvalid(.invalid):
                errorMessage = L10n.Auth.Error.invalidEmail
            case .passwordEmpty:
                errorMessage = L10n.Auth.Error.emptyPassword
            case .passwordTooShort(let minLength):
                errorMessage = L10n.Auth.Error.shortPassword(minLength)
            case .confirmNotMatch:
                errorMessage = L10n.Common.tryAgainLater
            }
            LocalNotificationView.shared.showError(L10n.Auth.Error.loginTitle, body: errorMessage)
        }
    }
    
    func loginSuccessful (user: UserModel) {
        self.isLoginSuccess.value = true
    }
}

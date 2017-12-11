//
//  RegisterVM.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift

protocol RegisterVMType {
    func register(email: String, password: String, confirm: String)
}

class RegisterVM: BaseViewModel, RegisterVMType {
    
    let authProvider: AuthProviderType!
    let userService: UserServiceType!
    let disposeBag = DisposeBag()
    
    init(authProvider: AuthProviderType, userService: UserServiceType) {
        self.userService = userService
        self.authProvider = authProvider
        super.init()
    }
    
    // TODO: cyclomatic_complexity must be fixed!
    // swiftlint:disable:next cyclomatic_complexity
    func register(email: String, password: String, confirm: String) {
        let validatedCredentials = registrationCredentialsRule.run((email: email, password: password, confirm: confirm))
        
        switch validatedCredentials {
        case .success(let email, let password, _):
            
            let register = authProvider.register(email: email, password: password)
                .trackActivity(in: loadingIndicator)
                .share(replay: 1)
            
            register.filterError()
                .subscribe(onNext: self.signupSuccessful)
                .disposed(by: disposeBag)
            
            register.errorOnly()
                .map { error in
                    switch error {
                    case .invalidEmail:
                        return L10n.Auth.Error.invalidEmail
                    case .emailAlreadyInUse:
                        return L10n.Auth.Error.emailAlreadyInUse
                    case .weakPassword(let reason):
                        return reason
                    default:
                        return L10n.Auth.Error.unknown
                    }
                }
                .subscribe(onNext: {
                    LocalNotificationView.shared.showError(L10n.Auth.Error.signupTitle, body: $0)
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
            LocalNotificationView.shared.showError(L10n.Auth.Error.signupTitle, body: errorMessage)
        }
        
    }
    
    func signupSuccessful (user: UserModel) {
        self.userService.setUserCreditFirstTime(userId: user.id)
            .asObservable()
            .trackActivity(in: loadingIndicator)
            .observeOn(MainScheduler.instance)
            .subscribe({_ in
                BGDidLoginEvent(user: user).send()
        }).disposed(by: disposeBag)
        
    }
}

//
//  LoginVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class LoginVC: BaseViewController {
    
    @IBOutlet weak var emailLbl: StyledLabel!
    @IBOutlet weak var passwordLbl: StyledLabel!
    @IBOutlet weak var mailTextField: StyledTextField!
    @IBOutlet weak var passwordTextField: StyledTextField!
    @IBOutlet weak var signInBtn: StyledButton!
    @IBOutlet weak var forgotBtn: StyledButton!
    
    var viewModel: LoginVMType!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
        self.emailLbl.text = L10n.Login.Signin.email
        self.passwordLbl.text = L10n.Login.Signin.password
        self.signInBtn.setTitle(L10n.Login.Signin.signInButton, for: .normal)
        self.forgotBtn.setTitle(L10n.Login.Signin.forgot, for: .normal)
    }
    
    func bindViewModel() {
        let username = mailTextField.rx.text
            .orEmpty
            .map({!$0.isEmpty})
            .share(replay: 1)
        
        let password = passwordTextField.rx.text
            .orEmpty
            .map({!$0.isEmpty})
            .share(replay: 1)
        
        let combinedSigninValues = Observable.combineLatest(username, password) { $0 && $1 }
            .share(replay: 1)
        
        combinedSigninValues
            .bind(to: signInBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signInBtn.rx.tap
            .subscribe(onNext: {
                self.signIn()
        }).disposed(by: disposeBag)
    }
    
    func signIn() {
        guard let email = self.mailTextField.text, email.isEmpty == false else {
            ShakeViewAnimation.shake(to: self.mailTextField)
            return
        }
        guard let password = self.passwordTextField.text, password.isEmpty == false else {
            ShakeViewAnimation.shake(to: self.passwordTextField)
            return
        }
        viewModel.login(email: email, password: password)
    }
}

extension LoginVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
    }
}

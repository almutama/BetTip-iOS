//
//  RegisterVc.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterVC: BaseViewController {
    
    @IBOutlet weak var requiredLbl: StyledLabel!
    @IBOutlet weak var emailLbl: StyledLabel!
    @IBOutlet weak var passwordLbl: StyledLabel!
    @IBOutlet weak var confirmLbl: StyledLabel!
    @IBOutlet weak var mailTextField: StyledTextField!
    @IBOutlet weak var passwordTextField: StyledTextField!
    @IBOutlet weak var confirmTextField: StyledTextField!
    @IBOutlet var signUpBtn: StyledButton!
    
    var viewModel: RegisterVMType!
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
        self.emailLbl.text = L10n.Login.SignUp.email
        self.passwordLbl.text = L10n.Login.SignUp.password
        self.confirmLbl.text = L10n.Login.SignUp.confirm
        self.requiredLbl.text = L10n.Login.SignUp.required
        self.signUpBtn.setTitle(L10n.Login.SignUp.signUpButton, for: .normal)
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
        
        let confirm = confirmTextField.rx.text
            .orEmpty
            .map({!$0.isEmpty})
            .share(replay: 1)
        
        let combinedSigninValues = Observable.combineLatest(username, password, confirm) { $0 && $1 && $2}
            .share(replay: 1)
        
        combinedSigninValues
            .bind(to: signUpBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signUpBtn.rx.tap
            .subscribe(onNext: {
                self.signUp()
            }).disposed(by: disposeBag)
    }
    
    func signUp() {
        guard let email = self.mailTextField.text, email.isEmpty == false else {
            ShakeViewAnimation.shake(to: self.mailTextField)
            return
        }
        guard let password = self.passwordTextField.text, password.isEmpty == false else {
            ShakeViewAnimation.shake(to: self.passwordTextField)
            return
        }
        guard let confirm = self.confirmTextField.text, confirm.isEmpty == false else {
            ShakeViewAnimation.shake(to: self.confirmTextField)
            return
        }
        if password != confirm {
            ShakeViewAnimation.shake(to: self.passwordTextField)
            ShakeViewAnimation.shake(to: self.confirmTextField)
            return
        }
        viewModel.register(email: email, password: password, confirm: confirm)
    }
}

extension RegisterVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
        
    }
}

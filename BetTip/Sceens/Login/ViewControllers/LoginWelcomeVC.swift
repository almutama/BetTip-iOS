//
//  LoginWelcomeVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class LoginWelcomeVC: BaseViewController {
    
    @IBOutlet weak var welcomeTitleLbl: UILabel!
    @IBOutlet weak var signInBtn: StyledButton!
    @IBOutlet weak var signUpBtn: StyledButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
        self.welcomeTitleLbl.text = L10n.Login.Welcome.title
        self.signInBtn.setTitle(L10n.Login.Welcome.signIn, for: .normal)
        self.signUpBtn.setTitle(L10n.Login.Welcome.signUp, for: .normal)
    }
}

extension LoginWelcomeVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
        
    }
}

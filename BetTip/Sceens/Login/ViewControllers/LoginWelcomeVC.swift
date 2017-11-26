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
    
    var viewModel: LoginVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoginWelcomeVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
        
    }
}

//
//  LoginVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class LoginVC: BaseViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: LoginVMType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoginVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
    }
}

//
//  RegisterVc.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class RegisterVC: BaseViewController {
    
    @IBOutlet weak var mailTextField: StyledTextField!
    @IBOutlet weak var passwordTextField: StyledTextField!
    @IBOutlet weak var confirmTextField: StyledTextField!
    @IBOutlet var signUpBtn: StyledButton!
    
    var viewModel: RegisterVMType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindViewModel() {
    }
    
    func signUp() {
        
    }
}

extension RegisterVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
        
    }
}

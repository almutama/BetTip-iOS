//
//  ForgotPasswordVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 26.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class ForgotPasswordVC: BaseViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var emailLbl: StyledLabel!
    @IBOutlet weak var descLbl: StyledLabel!
    @IBOutlet weak var sendBtn: StyledButton!
    
    var viewModel: ForgotPasswordVMType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
        self.emailLbl.text = L10n.Login.Forgot.email
        self.descLbl.text = L10n.Login.Forgot.desc
        self.sendBtn.setTitle(L10n.Login.Forgot.send, for: .normal)
    }
    
}

extension ForgotPasswordVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
        
    }
}

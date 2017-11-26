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
    
    var viewModel: ForgotPasswordVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ForgotPasswordVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
        
    }
}

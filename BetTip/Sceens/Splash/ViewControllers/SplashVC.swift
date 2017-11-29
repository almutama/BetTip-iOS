//
//  SplashVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class SplashVC: BaseViewController {
    
    var viewModel: SplashVM!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindViewModel() {
        self.viewModel.checkAuth { user in
            if let user = user {
                BGDidLoginEvent(user: user).send()
            } else {
                UIShowLoginScreenEvent(.transitionCrossDissolve).send()
            }
        }
    }
}

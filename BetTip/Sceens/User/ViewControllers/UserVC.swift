//
//  UserVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class UserVC: BaseViewController {
    
    var viewModel: UserVM!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindViewModel() {
        self.viewModel.getUser()
        self.viewModel.userModel.asObservable().subscribe(onNext: {[weak self] (_) in
            self?.prepareUI()
        }).disposed(by: self.disposeBag)
    }
    
    func prepareUI() {
        
    }
}

extension UserVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
        
    }
}

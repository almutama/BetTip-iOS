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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func bindViewModel() {
        self.viewModel.checkAuth()
        self.viewModel.userModel.asObservable().subscribe(onNext: {[weak self] (_) in
            print("")
        }).disposed(by: self.disposeBag)
    }
}

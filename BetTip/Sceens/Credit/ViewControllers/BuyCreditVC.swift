//
//  BuyCreditVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 2.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class BuyCreditVC: BaseViewController {
    
    var viewModel: BuyCreditVMType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindViewModel() {
    }
}

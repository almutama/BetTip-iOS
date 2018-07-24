//
//  AdminVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class AdminVC: BaseViewController {
    
    var viewModel: AdminVMType!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
    }
    
    func bindViewModel() {
        self.closeButton.rx.tap.subscribe({ _ in
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
}

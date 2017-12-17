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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var controlUsersView: UIView!
    @IBOutlet weak var controlCreditsView: UIView!
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
        self.segmentedControl
            .rx
            .selectedSegmentIndex
            .subscribe({
                guard let value = $0.element else {
                    return
                }
                if value == 0 {
                    self.controlUsersView.isHidden = true
                    self.controlCreditsView.isHidden = false
                } else {
                    self.controlUsersView.isHidden = false
                    self.controlCreditsView.isHidden = true
                }
            })
            .disposed(by: self.disposeBag)
        
        self.closeButton.rx.tap.subscribe(onNext: {
            self.dismiss()
        }).disposed(by: disposeBag)
    }
}

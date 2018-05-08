//
//  AddMatchVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 31.03.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AddMatchVC: BaseViewController {
    
    var viewModel: AddMatchVMType!
    private let disposeBag = DisposeBag()
    private let isLoading = Variable<Bool>(false)
    
    @IBOutlet weak var saveMatchButton: UIButton!
    
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
        self.bindAnimateWith(variable: self.isLoading)
            .disposed(by: disposeBag)
        
        self.saveMatchButton.rx.tap
            .subscribe(onNext: {[weak self] (_) in
                guard let strongSelf = self else { return }
                print(strongSelf.nibName ?? "")
            }).disposed(by: disposeBag)
    }
    
    func saveMatch() {
        
    }
}

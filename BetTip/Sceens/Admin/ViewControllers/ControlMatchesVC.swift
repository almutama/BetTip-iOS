//
//  ControlMatchesVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class ControlMatchesVC: BaseViewController {    
    
    var viewModel: ControlMatchesVMType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
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
    }
}

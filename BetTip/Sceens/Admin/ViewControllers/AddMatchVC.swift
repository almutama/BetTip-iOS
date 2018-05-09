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
import Eureka

class AddMatchVC: BaseFormViewController {
    
    var viewModel: AddMatchVMType!
    private let disposeBag = DisposeBag()
    private let isLoading = Variable<Bool>(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
        self.tableView?.backgroundColor = .main
        form +++ self.matchSection()
    }
    
    func bindViewModel() {
        self.bindAnimateWith(variable: self.isLoading)
            .disposed(by: disposeBag)
    }
    
    private func matchSection() -> Section {
        return Section()
            <<< TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< ButtonRow {
                    $0.title = "SAVE MATCH"
                }
                .cellUpdate { cell, _ in
                    cell.backgroundColor = .secondary
                    cell.textLabel?.textColor = .white
                    cell.textLabel?.textAlignment = .center
                }
                .onCellSelection { _, _ in
                    self.saveMatch()
        }
    }
    
    private func saveMatch() {
        print("save match")
    }
}

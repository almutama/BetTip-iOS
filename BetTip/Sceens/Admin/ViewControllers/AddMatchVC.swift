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
            <<< MatchTextCell { row in
                row.title = L10n.Matchform.homeTeam
                row.placeholder = ""
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell { row in
                row.title = L10n.Matchform.bet
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell { row in
                row.title = L10n.Matchform.awayTeam
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell { row in
                row.title = L10n.Matchform.league
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell { row in
                row.title = L10n.Matchform.country
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchIntCell { row in
                row.title = L10n.Matchform.betID
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchDecimalCell { row in
                row.title = L10n.Matchform.odd
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }

            <<< MatchDateCell {
                $0.title = L10n.Matchform.date
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.value = Date()
                print($0.value?.description ?? "")
                }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = .secondary
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
                }
                .onChange { [weak self] row in
                    print(row.value?.description ?? "")
                    row.updateCell()
                }
            <<< MatchTimeCell {
                $0.title = L10n.Matchform.time
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.value = Date()
                print($0.value?.description ?? "")
                }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = .secondary
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
                }
                .onChange { [weak self] row in
                    print(row.value?.description ?? "")
                    row.updateCell()
            }
            <<< MatchIntCell { row in
                row.title = L10n.Matchform.type
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchIntCell { row in
                row.title = L10n.Matchform.won
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell { row in
                row.title = L10n.Matchform.tipster
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell { row in
                row.title = L10n.Matchform.status
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell { row in
                row.title = L10n.Matchform.webSite
                row.placeholder = "Enter text here"
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< ButtonRow {
                $0.title = L10n.Matchform.saveMatch
                }
                .cellUpdate { cell, _ in
                    cell.backgroundColor = .secondary
                    cell.textLabel?.textColor = .white
                    cell.textLabel?.textAlignment = .center
                    cell.height = { 50 }
                }
                .onCellSelection { _, _ in
                    self.saveMatch()
            }
    }
    
    private func saveMatch() {
        print("save match")
    }
}

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
import ObjectMapper

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
    
    // swiftlint:disable cyclomatic_complexity
    private func matchSection() -> Section {
        let headerTitle = L10n.MatchForm.headerTitle
        let footerTitle = L10n.MatchForm.footerTitle
        
        return Section(header: headerTitle, footer: footerTitle) {
            $0.header?.height = { 50 }
            $0.footer?.height = { 30 }
            }
            <<< MatchTextCell("homeTeam") { row in
                row.title = L10n.MatchForm.homeTeam
                row.placeholder = L10n.MatchForm.HomeTeam.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("bet") { row in
                row.title = L10n.MatchForm.bet
                row.placeholder = L10n.MatchForm.Bet.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("awayTeam") { row in
                row.title = L10n.MatchForm.awayTeam
                row.placeholder = L10n.MatchForm.AwayTeam.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("league") { row in
                row.title = L10n.MatchForm.league
                row.placeholder = L10n.MatchForm.League.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("country") { row in
                row.title = L10n.MatchForm.country
                row.placeholder = L10n.MatchForm.Country.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchIntCell("iddaaId") { row in
                row.title = L10n.MatchForm.betID
                row.placeholder = L10n.MatchForm.BetID.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchDecimalCell("odd") { row in
                row.title = L10n.MatchForm.odd
                row.placeholder = L10n.MatchForm.Odd.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }

            <<< MatchDateCell("date") {
                $0.title = L10n.MatchForm.date
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
                    guard self != nil else { return }
                    print(row.value?.description ?? "")
                    row.updateCell()
                }
            <<< MatchTimeCell("time") {
                $0.title = L10n.MatchForm.time
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.value = NSDate.oneHourFromNow() as Date
                print($0.value?.description ?? "")
                }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = .secondary
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
                }
                .onChange { [weak self] row in
                    guard self != nil else { return }
                    print(row.value?.description ?? "")
                    row.updateCell()
            }
            <<< MatchIntCell("type") { row in
                row.title = L10n.MatchForm.type
                row.placeholder = L10n.MatchForm.MatchType.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchIntCell("won") { row in
                row.title = L10n.MatchForm.won
                row.placeholder = L10n.MatchForm.Won.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchMailCell("tipster") { row in
                row.title = L10n.MatchForm.tipster
                row.placeholder = L10n.MatchForm.Tipster.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchIntCell("status") { row in
                row.title = L10n.MatchForm.status
                row.placeholder = L10n.MatchForm.Status.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("site") { row in
                row.title = L10n.MatchForm.webSite
                row.placeholder = L10n.MatchForm.WebSite.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchSwitchCell() { row in
                row.tag = "isSpecial"
                row.title = L10n.MatchForm.isCoupon
                }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = .secondary
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
            }
            <<< ButtonRow {
                $0.title = L10n.MatchForm.saveMatch
                }
                .cellUpdate { cell, _ in
                    cell.backgroundColor = .secondary
                    cell.textLabel?.textColor = .white
                    cell.textLabel?.textAlignment = .center
                    cell.height = { 60 }
                }
                .onCellSelection { _, row in
                    guard let isValid = row.section?.form?.validate() else { return }
                    if  isValid.isEmpty {
                        self.saveMatch(values: self.form.values())
                    }
            }
    } // swiftlint:enable cyclomatic_complexity
    
    private func saveMatch(values: [String: Any?]) {
        guard let match = MatchModel(form: values) else { return }
        print("match: \(match)")
        let dictionary = Mapper<MatchModel>().toJSON(match)
        print("dic: \(dictionary)")
        self.viewModel.addMatch(match: match) { result in
            if let result = result {
                self.showNotification(result: result)
                self.matchSection().reload()
            }
        }
    }
}

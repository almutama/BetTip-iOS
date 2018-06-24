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
        let headerTitle = L10n.Matchform.headerTitle
        let footerTitle = L10n.Matchform.footerTitle
        
        return Section(header: headerTitle, footer: footerTitle) {
            $0.header?.height = { 50 }
            $0.footer?.height = { 30 }
            }
            <<< MatchTextCell("homeTeam") { row in
                row.title = L10n.Matchform.homeTeam
                row.placeholder = L10n.Matchform.Hometeam.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("bet") { row in
                row.title = L10n.Matchform.bet
                row.placeholder = L10n.Matchform.Bet.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("awayTeam") { row in
                row.title = L10n.Matchform.awayTeam
                row.placeholder = L10n.Matchform.Awayteam.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("league") { row in
                row.title = L10n.Matchform.league
                row.placeholder = L10n.Matchform.League.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("country") { row in
                row.title = L10n.Matchform.country
                row.placeholder = L10n.Matchform.Country.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchIntCell("iddaaId") { row in
                row.title = L10n.Matchform.betID
                row.placeholder = L10n.Matchform.Betid.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchDecimalCell("odd") { row in
                row.title = L10n.Matchform.odd
                row.placeholder = L10n.Matchform.Odd.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }

            <<< MatchDateCell("date") {
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
                    guard self != nil else { return }
                    print(row.value?.description ?? "")
                    row.updateCell()
                }
            <<< MatchTimeCell("time") {
                $0.title = L10n.Matchform.time
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
                row.title = L10n.Matchform.type
                row.placeholder = L10n.Matchform.Matchtype.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchIntCell("won") { row in
                row.title = L10n.Matchform.won
                row.placeholder = L10n.Matchform.Won.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchMailCell("tipster") { row in
                row.title = L10n.Matchform.tipster
                row.placeholder = L10n.Matchform.Tipster.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchIntCell("status") { row in
                row.title = L10n.Matchform.status
                row.placeholder = L10n.Matchform.Status.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchTextCell("site") { row in
                row.title = L10n.Matchform.webSite
                row.placeholder = L10n.Matchform.Website.placeholder
                }.cellUpdate { cell, row in
                    cell.titleLabel?.textColor = .secondary
                    cell.textField.textColor = .white
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< MatchSwitchCell("isSpecial") { row in
                row.title = L10n.Matchform.isCoupon
                }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = .secondary
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
            }
            <<< ButtonRow {
                $0.title = L10n.Matchform.saveMatch
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

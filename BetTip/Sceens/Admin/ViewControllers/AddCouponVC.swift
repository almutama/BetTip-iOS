//
//  AddCouponVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ObjectMapper

class AddCouponVC: BaseViewController {
    
    var viewModel: AddCouponVMType!
    private let disposeBag = DisposeBag()
    private let isLoading = Variable<Bool>(false)
    private var selectedMatches: Variable<[MatchModel]> = Variable<[MatchModel]>([])
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectMatchTypeButton: UIButton!
    @IBOutlet weak var saveCouponButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
        self.tableView.registerCellNib(MatchCell.self)
        self.getMatchesWithType(type: .football)
    }
    
    func bindViewModel() {
        let setPlaceholder: (String?) -> (UITextField) -> Void = { placeholder in {
            $0.placeholder = placeholder
            $0.keyboardType = .decimalPad
            }
        }
        
        self.bindAnimateWith(variable: self.isLoading)
            .disposed(by: disposeBag)
        
        self.viewModel
            .matches.asObservable()
            .map { _ in false }.startWith(true)
            .catchErrorJustReturn(false)
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
        self.viewModel
            .matches
            .asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: MatchCell.reuseIdentifier,
                                                   cellType: MatchCell.self)) { _, data, cell in
                                                    cell.viewModel = Variable<MatchModel>(data)
            }.disposed(by: disposeBag)
        
        self.selectMatchTypeButton.rx.tap
            .flatMap { [unowned self] in
                UIAlertController.rx
                    .presented(
                        by: self,
                        title: L10n.Credit.title,
                        message: L10n.Credit.addCredit,
                        preferredStyle: UIAlertControllerStyle.actionSheet,
                        actions: [MatchAction.basketball, MatchAction.football, MatchAction.cancel],
                        animated: true
                )
            }
            .subscribe(onNext: { action in
                switch action {
                case .basketball, .football:
                    self.getMatchesWithType(type: action)
                    self.selectedMatches.value = []
                case .cancel: break
                }
            })
            .disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(MatchModel.self)
            .subscribe(onNext: { [weak self] match in
                self?.selectedMatches.value.append(match)
            })
            .disposed(by: disposeBag)
        
        self.tableView.rx.modelDeselected(MatchModel.self)
            .subscribe(onNext: { [weak self] match in
                guard let strongSelf = self else { return }
                let newList = strongSelf.selectedMatches.value.filter { value in
                    return !(value.iddaaId ==? match.iddaaId &&
                        value.bet ==? match.bet &&
                        value.odd ==? match.odd)
                }
                strongSelf.selectedMatches.value = newList
                
            })
            .disposed(by: disposeBag)
        
        self.selectedMatches.asObservable()
            .subscribe(onNext: {[weak self] (_) in
                guard let strongSelf = self else { return }
                let selectedCount = strongSelf.selectedMatches.value.count
                strongSelf.saveCouponButton.isEnabled = strongSelf.selectedMatches.value.isEmpty ? false : true
                strongSelf.saveCouponButton.alpha = selectedCount > 0 ? 1.0 : 0.5
            }).disposed(by: disposeBag)
        
        self.saveCouponButton.rx.tap
            .flatMap { [unowned self] in
                UIAlertController.rx
                    .presented(
                        by: self,
                        title: L10n.Credit.title,
                        message: L10n.Credit.addCredit,
                        actions: [AlertAction.ok, AlertAction.cancel],
                        textFields: [setPlaceholder(L10n.Credit.numberOfCredit)]
                )
            }
            .subscribe(onNext: { action, texts in
                switch action {
                case .ok:
                    self.addCoupon(coupon: self.makeCoupon(texts: texts))
                case .cancel: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func getMatchesWithType(type: MatchAction) {
        if type == .football {
            self.selectMatchTypeButton.setImage(Asset.TabBar.tabSelFootball.image, for: .normal)
        } else if type == .basketball {
            self.selectMatchTypeButton.setImage(Asset.TabBar.tabSelBasketball.image, for: .normal)
        }
        self.viewModel.getMatchesWithType(type: type)
    }
    
    func makeCoupon(texts: [String?]?) -> CouponModel {
        var numberOfCredit = 0
        texts?.enumerated().forEach {
            numberOfCredit = $0.element.map { value -> Int in
                return Int(value) ?? 0
                }!
        }
        var odd: Double = 1.0
        for match in self.selectedMatches.value {
            if let matchOdd = match.odd {
                odd = matchOdd * odd
            }
        }
        
        let startDate: Date = self.selectedMatches.value.map { $0.date! + " " + $0.time! }.getFirstDateFromArray(with: "dd.MM.yyyy HH:mm")
        let roundedOdd: Double = odd.roundTo(places: 2)
        let tipster: String = UserEventService.shared.user.value?.email ?? ""
        let matches: Array = selectedMatches.value
        
        // TODO: Fix dateWithFormat return values
        return CouponModel(numOfCredit: numberOfCredit,
                           startDate: startDate.dateWithFormat(dateFormat: "dd.MM.yyyy"),
                           startTime: startDate.dateWithFormat(dateFormat: "HH:mm"),
                           odd: roundedOdd,
                           won: -1,
                           tipster: tipster,
                           matches: matches)!
    }
    
    func addCoupon(coupon: CouponModel) {
        self.viewModel.addCoupon(coupon: coupon) { result in
            if let result = result {
                self.showNotification(result: result)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

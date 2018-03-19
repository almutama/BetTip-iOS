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
                print("deleted match: ", match.iddaaId!)
                print(strongSelf.selectedMatches.value.filter { $0 !== match })
                
            })
            .disposed(by: disposeBag)
        
        self.selectedMatches.asObservable()
            .subscribe(onNext: {[weak self] (_) in
                guard let strongSelf = self else { return }
                let selectedCount = strongSelf.selectedMatches.value.count
                print(selectedCount)
                strongSelf.saveCouponButton.isEnabled = strongSelf.selectedMatches.value.isEmpty ? false : true
                strongSelf.saveCouponButton.alpha = selectedCount > 0 ? 1.0 : 0.5
            }).disposed(by: disposeBag)
        
        self.saveCouponButton.rx.tap
            .subscribe(onNext: {[weak self] (_) in
                guard let strongSelf = self else { return }
                print(strongSelf.selectedMatches.value)
            }).disposed(by: disposeBag)
    }
    
    func getMatchesWithType(type: MatchAction) {
        if type == .football {
            self.selectMatchTypeButton.setImage(Asset.TabBar.tabSelFootball.image, for: .normal)
        } else if type == .basketball {
            self.selectMatchTypeButton.setImage(Asset.TabBar.tabSelBasketball.image, for: .normal)
        }
        self.viewModel.getMatchesWithType(type: type)
    }
    
    func makeCoupon(numOfCredit: Int) -> CouponModel {
        var odd: Double = 1.0
        for match in self.selectedMatches.value {
            if let matchOdd = match.odd {
                odd = matchOdd * odd
            }
        }
        let startDate = Date().dateWithFormat()
        guard let email = UserEventService.shared.user.value?.email else {
            return CouponModel(numOfCredit: numOfCredit, startDate: startDate, odd: odd, won: -1, tipster: "", matches: selectedMatches.value)
        }
        return CouponModel(numOfCredit: numOfCredit, startDate: startDate, odd: odd, won: -1, tipster: email, matches: selectedMatches.value)
    }
    
    func saveCoupon() {
        
    }
}

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
    private let isLoading = Variable<Bool>(false)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectMatchTypeButton: UIButton!
    
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
                        preferredStyle: UIAlertController.Style.actionSheet,
                        actions: [MatchAction.basketball, MatchAction.football, MatchAction.cancel],
                        animated: true
                )
            }
            .subscribe(onNext: { action in
                switch action {
                case .basketball, .football:
                    self.getMatchesWithType(type: action)
                case .cancel: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func getMatchesWithType(type: MatchAction) {
        if type == .football {
            self.selectMatchTypeButton.setImage(Asset.tabSelFootball.image, for: .normal)
        } else if type == .basketball {
            self.selectMatchTypeButton.setImage(Asset.tabSelBasketball.image, for: .normal)
        }
        self.viewModel.getMatchesWithType(type: type)
    }
}

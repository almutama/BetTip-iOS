//
//  AddCouponVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import VegaScrollFlowLayout

class AddCouponVC: BaseViewController {
    
    var viewModel: AddCouponVMType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
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
        let layout = VegaScrollFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 100)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(BasketballCell.self)
        self.getMatchesWithType(type: .football)
    }
    
    func getMatchesWithType(type: MatchAction) {
        if type == .football {
            self.selectMatchTypeButton.setImage(Asset.TabBar.tabSelFootball.image, for: .normal)
        } else if type == .basketball {
            self.selectMatchTypeButton.setImage(Asset.TabBar.tabSelBasketball.image, for: .normal)
        }
        self.viewModel
            .getMatches(type: type)
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: BasketballCell.reuseIdentifier,
                                                   cellType: BasketballCell.self)) { _, data, cell in
                                                   cell.viewModel = Variable<MatchModel>(data)
            }.disposed(by: disposeBag)
    }
    
    func bindViewModel() {
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
                case .cancel: break
                }
            })
            .disposed(by: disposeBag)
    }
}

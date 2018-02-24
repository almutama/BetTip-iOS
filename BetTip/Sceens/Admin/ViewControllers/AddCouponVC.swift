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
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.allowsSelection = true
            collectionView.allowsMultipleSelection = true
        }
    }
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
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 100)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(MatchCell.self)
        self.getMatchesWithType(type: .football)
    }
    
    func getMatchesWithType(type: MatchAction) {
        if type == .football {
            self.selectMatchTypeButton.setImage(Asset.TabBar.tabSelFootball.image, for: .normal)
        } else if type == .basketball {
            self.selectMatchTypeButton.setImage(Asset.TabBar.tabSelBasketball.image, for: .normal)
        }
        self.viewModel.getMatchesWithType(type: type)
    }
    
    func bindViewModel() {
        _ = RxCollectionViewSectionedReloadDataSource<SectionModel<String, MatchModel>>(
            configureCell: { (_, collectionView, indexPath, data) in
                if let cell : MatchCell = (collectionView.dequeueReusableCell(withReuseIdentifier: MatchCell.reuseIdentifier, for: indexPath) as? MatchCell) {
                    cell.viewModel = Variable<MatchModel>(data)
                    return cell
                }
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCell.reuseIdentifier, for: indexPath) as? MatchCell else { return UICollectionViewCell()}
                return cell
            },
                configureSupplementaryView: { (_, _, _, _) in
                    return UICollectionReusableView()
            }
        )
        
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
            .bind(to: self.collectionView.rx.items(cellIdentifier: MatchCell.reuseIdentifier,
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
                case .cancel: break
                }
            })
            .disposed(by: disposeBag)
        
        self.collectionView.rx.modelSelected(MatchModel.self)
            .subscribe(onNext: { [weak self] match in
                print("bastiiii")
                self?.selectedMatches.value.append(match)
            })
            .disposed(by: disposeBag)
        
        self.collectionView.rx.itemSelected.asObservable()
            .subscribe(onNext: { [unowned self] indexPath in
                guard let cell = self.collectionView.cellForItem(at: indexPath) as? MatchCell else {return}
                cell.isSelected = false
            })
            .disposed(by: disposeBag)
    }
    
    func mapToCollectionSection (_ matches: [MatchModel]) -> SectionModel<String, MatchModel> {
        return SectionModel(model: "matches", items: matches)
    }
}

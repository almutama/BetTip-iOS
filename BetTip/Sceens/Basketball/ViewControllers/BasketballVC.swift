//
//  BasketballViewController.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import VegaScrollFlowLayout

class BasketballVC: BaseViewController {
    
    var viewModel: BasketballVMType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(BasketballCell.self)
    }
    
    func bindViewModel() {
        self.viewModel
            .getBasketballMatches()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: BasketballCell.reuseIdentifier,
                                                   cellType: BasketballCell.self)) { _, data, cell in
                cell.viewModel = Variable<BasketballModel>(data)
            }.disposed(by: disposeBag)
    }
}

extension BasketballVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 90)
    }
}

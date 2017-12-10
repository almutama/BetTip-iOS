//
//  CouponVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import VegaScrollFlowLayout

class CreditsVC: BaseViewController {
    
    var viewModel: CreditsVMType!
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
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(CreditCell.self)
    }
    
    func bindViewModel() {
        self.viewModel
            .getCredits()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: CreditCell.reuseIdentifier,
                                                   cellType: CreditCell.self)) { _, data, cell in
                                                    cell.viewModel = Variable<CreditModel>(data)
            }.disposed(by: disposeBag)
    }
}

extension CreditsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 90)
    }
}

//
//  MyCouponDetailVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class MyCouponDetailVC: BaseViewController {
    
    var viewModel: MyCouponDetailVMType!
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
        self.navigationItem.title = "FIRSAT BAHİS"
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 100)
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

//
//  ControlCouponsVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 13.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class ControlCouponsVC: BaseViewController {
    
    var viewModel: ControlCouponsVMType!
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
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 70)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(CouponCell.self)
    }
    
    func bindViewModel() {
        self.viewModel
            .getCoupons()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: CouponCell.reuseIdentifier,
                                                   cellType: CouponCell.self)) { _, data, cell in
                                                    cell.viewModel = Variable<CouponModel>(data)
            }.disposed(by: disposeBag)
    }
}

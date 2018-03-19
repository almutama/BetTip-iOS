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
    
    var viewModel: ControlCouponsVM!
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

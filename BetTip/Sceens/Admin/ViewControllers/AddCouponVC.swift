//
//  AddCouponVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class AddCouponVC: BaseViewController {
    
    var viewModel: AddCouponVMType!
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
            .getMatches()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: BasketballCell.reuseIdentifier,
                                                   cellType: BasketballCell.self)) { _, data, cell in
                                                   cell.viewModel = Variable<MatchModel>(data)
            }.disposed(by: disposeBag)
    }
}

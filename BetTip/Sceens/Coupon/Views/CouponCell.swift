//
//  CouponCell.swift
//  BetTip
//
//  Created by Haydar Karkin on 16.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CouponCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var numberOfCreditLbl: StyledLabel!
    @IBOutlet weak var priceLbl: StyledLabel!
    
    var disposeBag = DisposeBag()
    var viewModel: Variable<CouponModel> = Variable<CouponModel>.init(CouponModel.init()) {
        didSet {
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element {
                        self.priceLbl.text = "\(String(describing: entity.price))"
                    }
                })
                .disposed(by: disposeBag)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

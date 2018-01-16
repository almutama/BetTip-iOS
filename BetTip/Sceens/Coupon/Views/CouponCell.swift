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
    @IBOutlet weak var dateLbl: StyledLabel!
    @IBOutlet weak var timeLbl: StyledLabel!
    @IBOutlet weak var rateLbl: StyledLabel!
    
    var disposeBag = DisposeBag()
    var viewModel: Variable<CouponModel> = Variable<CouponModel>.init(CouponModel.init()) {
        didSet {
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element {
                        self.numberOfCreditLbl.text = "\(String(describing: entity.numOfCredit))"
                        self.dateLbl.text = "\(String(describing: entity.date))"
                        self.timeLbl.text = "\(String(describing: entity.time))"
                        self.rateLbl.text = "\(String(describing: entity.rate))"
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

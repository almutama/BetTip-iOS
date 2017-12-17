//
//  CouponCell.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CreditCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var numberOfCreditLbl: StyledLabel!
    @IBOutlet weak var priceLbl: StyledLabel!
    
    var disposeBag = DisposeBag()
    var viewModel: Variable<CreditModel> = Variable<CreditModel>.init(CreditModel.init()) {
        didSet {
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element {
                        self.numberOfCreditLbl.text = "\(String(describing: entity.numberOfCredits))"
                        self.priceLbl.text = "\(String(describing: entity.price))"
                        
                        if let numberOfCredits = entity.numberOfCredits, let price = entity.price {
                            self.numberOfCreditLbl.text = "\(numberOfCredits)"
                            self.priceLbl.text = "\(price) TL"
                        } else {
                            self.numberOfCreditLbl.text = "-"
                            self.priceLbl.text = "-"
                        }
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

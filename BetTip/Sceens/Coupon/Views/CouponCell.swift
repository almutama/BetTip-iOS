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
    @IBOutlet weak var tipsterLbl: StyledLabel!
    
    var disposeBag = DisposeBag()
    var viewModel: Variable<CouponModel> = Variable<CouponModel>.init(CouponModel.init()) {
        didSet {
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element {
                        if let numOfCredit = entity.numOfCredit,
                            let startDate = entity.startDate,
                            let odd = entity.odd,
                            let tipster = entity.tipster {
                            self.numberOfCreditLbl.text = "\(numOfCredit)"
                            self.dateLbl.text = "\(startDate)"
                            //self.timeLbl.text = "\(String(describing: entity.time))"
                            self.rateLbl.text = "\(odd)"
                            self.tipsterLbl.text = "\(tipster)"
                        } else {
                            self.numberOfCreditLbl.text = "-"
                            self.dateLbl.text = "-"
                            self.timeLbl.text = "-"
                            self.rateLbl.text = "-"
                            self.tipsterLbl.text = "-"
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.secondary.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }

}

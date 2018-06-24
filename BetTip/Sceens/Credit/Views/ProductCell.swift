//
//  ProductCell.swift
//  BetTip
//
//  Created by Haydar Karkin on 14.06.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProductCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var numberOfCreditLbl: StyledLabel!
    @IBOutlet weak var priceLbl: StyledLabel!
    
    var disposeBag = DisposeBag()
    var viewModel: Variable<SKProduct> = Variable<SKProduct>.init(SKProduct.init()) {
        didSet {
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element {
                        self.numberOfCreditLbl.text = "\(entity.localizedTitle)"
                        self.priceLbl.text = "\(entity.localizedPrice)"
                    }
                })
                .disposed(by: disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
}

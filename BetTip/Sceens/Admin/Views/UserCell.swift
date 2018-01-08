//
//  UserCell.swift
//  BetTip
//
//  Created by Haydar Karkin on 16.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UserCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var userMailLbl: StyledLabel!
    @IBOutlet weak var userRoleLbl: StyledLabel!
    @IBOutlet weak var disableView: UIView!
    
    var disposeBag = DisposeBag()
    var viewModel: Variable<UserModel> = Variable<UserModel>.init(UserModel.init()) {
        didSet {
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element {
                        self.userMailLbl.text = entity.email
                        self.userRoleLbl.text = entity.role.localizedName
                        self.disableView.isHidden = entity.disabled ? false : true
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

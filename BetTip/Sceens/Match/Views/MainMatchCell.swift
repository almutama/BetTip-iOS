//
//  MainMatchCell.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.06.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainMatchCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var iddaaIdLbl: StyledLabel!
    @IBOutlet weak var homeLbl: StyledLabel!
    @IBOutlet weak var awayLbl: StyledLabel!
    @IBOutlet weak var dateLbl: StyledLabel!
    @IBOutlet weak var timeLbl: StyledLabel!
    @IBOutlet weak var leagueLbl: StyledLabel!
    @IBOutlet weak var betLbl: StyledLabel!
    @IBOutlet weak var oddLbl: StyledLabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var siteLbl: StyledLabel!
    @IBOutlet weak var isSpecialView: UIView!
    
    var disposeBag = DisposeBag()
    var viewModel: Variable<MatchModel> = Variable<MatchModel>.init(MatchModel.init()) {
        didSet {
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element {
                        self.homeLbl.text = entity.homeTeam
                        self.awayLbl.text = entity.awayTeam
                        self.dateLbl.text = entity.date
                        self.timeLbl.text = entity.time
                        self.betLbl.text = entity.bet
                        self.leagueLbl.text = entity.league
                        self.siteLbl.text = entity.site
                        
                        if let odd = entity.odd, let iddiaId = entity.iddaaId {
                            self.oddLbl.text = "\(odd)"
                            self.iddaaIdLbl.text = "\(iddiaId)"
                        } else {
                            self.oddLbl.text = "-"
                            self.iddaaIdLbl.text = "-"
                        }
                        
                        if entity.status == 1 {
                            self.statusImg.image = Asset.active.image
                        } else {
                            if entity.won == 0 {
                                self.statusImg.image = Asset.lost.image
                            } else {
                                self.statusImg.image = Asset.won.image
                            }
                        }
                        
                        if let isSpecial = entity.isSpecial {
                            if isSpecial == true {
                                self.isSpecialView.backgroundColor = .secondary
                            }
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.masksToBounds = false
    }
}

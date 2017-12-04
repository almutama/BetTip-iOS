//
//  FootballCell.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FootballCell: UICollectionViewCell, Reusable {

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
    
    var disposeBag = DisposeBag()
    var viewModel: Variable<FootballModel> = Variable<FootballModel>.init(FootballModel.init()) {
        didSet {
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element {
                        self.homeLbl.text = entity.homeTeam
                        self.awayLbl.text = entity.awayTeam
                        self.dateLbl.text = entity.date
                        self.timeLbl.text = entity.time
                        self.betLbl.text = entity.bet
                        self.oddLbl.text = "\(String(describing: entity.odd))"
                        self.leagueLbl.text = entity.league
                        self.siteLbl.text = entity.site
                        self.iddaaIdLbl.text = "\(String(describing: entity.iddaaId))"
                        
                        if entity.status == 1 {
                            self.statusImg.image = Asset.active.image
                        } else {
                            if entity.won == 0 {
                                self.statusImg.image = Asset.lost.image
                            } else {
                                self.statusImg.image = Asset.won.image
                            }
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

//
//  FootballVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import VegaScrollFlowLayout

class FootballVC: BaseViewController {
    
    var viewModel: FootballVMType!
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
        let layout = VegaScrollFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(FootballCell.self)
    }
    
    func bindViewModel() {
        self.viewModel
            .getFootballMatches()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: FootballCell.reuseIdentifier,
                                                   cellType: FootballCell.self)) { _, data, cell in
                cell.viewModel = Variable<FootballModel>(data)
            }.disposed(by: disposeBag)
    }
}

extension FootballVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 90)
    }
}

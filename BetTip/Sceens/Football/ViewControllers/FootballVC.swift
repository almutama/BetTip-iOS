//
//  FootballVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class FootballVC: BaseViewController {
    
    var viewModel: FootballVMType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

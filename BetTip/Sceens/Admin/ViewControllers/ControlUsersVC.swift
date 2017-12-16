//
//  ControlUsersVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 5.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ControlUsersVC: BaseViewController {
    
    var viewModel: ControlUsersVMType!
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
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 60)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(UserCell.self)
    }
    
    func bindViewModel() {
        self.viewModel
            .getUsers()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: UserCell.reuseIdentifier,
                                                   cellType: UserCell.self)) { _, data, cell in
                                                    cell.viewModel = Variable<UserModel>(data)
            }.disposed(by: disposeBag)
    }
}

//
//  MyCouponsVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class MyCouponsVC: BaseViewController {
    
    var viewModel: MyCouponsVMType!
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
        self.navigationItem.title = "FIRSAT BAHİS"
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 70)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(CouponCell.self)
    }
    
    func bindViewModel() {
        self.viewModel
            .getCoupons()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: CouponCell.reuseIdentifier,
                                                   cellType: CouponCell.self)) { _, data, cell in
                                                    cell.viewModel = Variable<CouponModel>(data)
            }.disposed(by: disposeBag)
        
        self.collectionView.rx.modelSelected(CouponModel.self)
            .subscribe(onNext: {coupon in
                self.performSegue(withIdentifier: StoryboardSegue.User.myCouponDetailSegue.rawValue,
                                  sender: coupon)
            })
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegue.User.myCouponDetailSegue.rawValue {
            guard let coupon = sender as? CouponModel else {
                return
            }
            guard let vc = segue.destination as? MyCouponDetailVC else {
                return
            }
            vc.viewModel = MyCouponDetailVM(coupon: Variable(coupon))
        }
    }
}

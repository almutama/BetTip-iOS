//
//  CouponVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 16.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CouponsVC: BaseViewController {
    
    var viewModel: CouponsVMType!
    private let disposeBag = DisposeBag()
    private let selectedCoupon = Variable<CouponModel?>(nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userCreditLbl: StyledLabel!
    
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
        
        // CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 70)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(CouponCell.self)
        
        // CreditLabel
        let userCredit = UserEventService.shared.user.value?.userCredit?.currentCredit ?? 0
        let fullCreditText = "\(L10n.User.Credit.rest)\(userCredit)"
        self.userCreditLbl.coloredText(fullText: fullCreditText, changeText: "\(userCredit)", color: .orange)
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
            .flatMap { (coupon) -> ControlEvent<CouponAction> in
                self.selectedCoupon.value = coupon
                return UIAlertController.rx
                    .presented(
                        by: self,
                        title: L10n.Coupon.title,
                        message: "\(coupon.numOfCredit ?? 0)\(L10n.Coupon.buyCoupon)",
                        preferredStyle: UIAlertControllerStyle.actionSheet,
                        actions: [CouponAction.buy, CouponAction.cancel],
                        animated: true
                )
            }
            .flatMap { [weak self] (action) -> Observable<Bool> in
                guard let `self` = self else { return Observable.empty() }
                switch action {
                case .buy:
                    return self.buyCoupon()
                case .cancel:
                    return Observable.empty()
                }
            }
            .subscribe(onNext: {result in
                self.showNotification(result: result)
            })
            .disposed(by: disposeBag)
    }
    
    func buyCoupon() -> Observable<Bool> {
        guard let coupon = self.selectedCoupon.value else {
            return Observable.empty()
        }
        return self.viewModel.buyCoupon(coupon: coupon)
    }
}

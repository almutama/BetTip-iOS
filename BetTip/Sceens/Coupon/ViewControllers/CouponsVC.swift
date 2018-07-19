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
import Result

class CouponsVC: BaseViewController {
    
    var viewModel: CouponsVMType!
    private let disposeBag = DisposeBag()
    
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
        self.navigationItem.title = L10n.Common.title
        
        // CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 70)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(CouponCell.self)
    }
    
    func coloredText(fullText: String, changeText: String, color: UIColor) -> NSMutableAttributedString {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        return attribute
    }
    
    func bindViewModel() {
        self.viewModel
            .getCoupons()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: CouponCell.reuseIdentifier,
                                                   cellType: CouponCell.self)) { _, data, cell in
                                                    cell.viewModel = Variable(data)
            }.disposed(by: disposeBag)
        
        self.viewModel.userCredit()
            .asObservable()
            .map {
                let fullCreditText = "\(L10n.User.Credit.rest)\($0)"
                return self.coloredText(fullText: fullCreditText, changeText: "\($0)", color: .secondary)
            }
            .bind(to: self.userCreditLbl.rx.attributedText)
            .disposed(by: disposeBag)
        
        self.collectionView.rx.modelSelected(CouponModel.self)
            .flatMap { (coupon) -> Observable<CouponResult> in
                if !coupon.isCouponExistForUser() {
                    return self.startBuyCoupon(coupon: coupon)
                }
                return Observable.just(CouponResult(result: true, resultAction: .openCoupon(coupon: coupon)))
            }
            .subscribe(onNext: {result in
                switch result.resultAction {
                case .buyCoupon: self.showNotification(result: result.result)
                case .openCoupon(let coupon): self.openUserCoupon(coupon: coupon)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func startBuyCoupon(coupon: CouponModel) -> Observable<CouponResult> {
        return UIAlertController.rx
            .presented(
                by: self,
                title: L10n.Coupon.title,
                message: "\(coupon.numOfCredit ?? 0)\(L10n.Coupon.buyCoupon)",
                preferredStyle: UIAlertControllerStyle.actionSheet,
                actions: [CouponAction.buy(coupon: coupon), CouponAction.cancel],
                animated: true
            ).flatMap { [weak self] (action) -> Observable<Result<CouponModel, FirebaseStoreError>> in
                guard let `self` = self else { return Observable.empty() }
                switch action {
                case .buy(let selectedCoupon):
                    return self.viewModel.buyCoupon(coupon: selectedCoupon)
                case .cancel:
                    return Observable.empty()
                }
            }
            .flatMap { [weak self] (result) -> Observable<CouponResult> in
                guard let `self` = self else { return Observable.empty() }
                switch result {
                case .success(let coupon):
                    return self.viewModel.setUserCredit(coupon: coupon)
                case .failure:
                    return Observable.just(CouponResult(result: false, resultAction: .buyCoupon))
                }
        }
    }
    
    func openUserCoupon(coupon: CouponModel) {
        self.performSegue(withIdentifier: StoryboardSegue.Coupon.couponDetailSegue.rawValue,
                          sender: coupon)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegue.Coupon.couponDetailSegue.rawValue {
            guard let coupon = sender as? CouponModel else {
                return
            }
            guard let vc = segue.destination as? CouponDetailVC else {
                return
            }
            vc.viewModel = CouponDetailVM(coupon: Variable(coupon))
        }
    }
}

//
//  CouponVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Result
import SwiftyStoreKit

private let logger = Log.createLogger()

class CreditsVC: BaseViewController {
    
    var viewModel: CreditsVMType!
    private let disposeBag = DisposeBag()
    private let isLoading = Variable<Bool>(false)
    
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
        self.navigationItem.title = L10n.Common.title
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 60)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(ProductCell.self)
    }
    
    func bindViewModel() {
        self.bindAnimateWith(variable: self.isLoading)
            .disposed(by: disposeBag)

        let credits = self.viewModel.getProducts()
            .asObservable()
            .delaySubscription(0, scheduler: MainScheduler.instance)
        
        credits.map { _ in false }.startWith(true)
            .catchErrorJustReturn(false)
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
        credits.bind(to:
            self.collectionView.rx.items(cellIdentifier: ProductCell.reuseIdentifier,
                                         cellType: ProductCell.self)) { _, data, cell in
                                            cell.viewModel = Variable<SKProduct>(data)
            }.disposed(by: disposeBag)
        
        self.collectionView.rx.modelSelected(SKProduct.self)
            .flatMap { (product) -> ControlEvent<CreditAction> in
                return UIAlertController.rx
                    .presented(
                        by: self,
                        title: L10n.Credit.title,
                        message: "\(product.localizedDescription)",
                        preferredStyle: UIAlertControllerStyle.actionSheet,
                        actions: [CreditAction.buy(selectedProduct: product), CreditAction.cancel],
                        animated: true
                )
            }
            .flatMap { [weak self] (action) -> Observable<Result<PurchaseDetails, SKError>> in
                guard let `self` = self else { return Observable.empty() }
                switch action {
                case .buy(let selectedProduct):
                    return self.viewModel.buyProduct(product: selectedProduct)
                case .cancel:
                    return Observable.empty()
                }
            }
            .flatMap { [weak self] (result) -> Observable<Bool> in
                guard let `self` = self else { return Observable.empty() }
                switch result {
                case .success(let purchasedResult):
                    return self.viewModel.setUserCredit(purchasedProduct: purchasedResult)
                case .failure:
                    return Observable.just(false)
                }
            }
            .subscribe(onNext: {result in
                self.showNotification(result: result)
            })
            .disposed(by: disposeBag)
    }
}

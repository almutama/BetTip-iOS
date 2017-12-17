//
//  CouponVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import VegaScrollFlowLayout
import PassKit

private let logger = Log.createLogger()

class CreditsVC: BaseViewController {
    
    var viewModel: CreditsVMType!
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
        let layout = VegaScrollFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 60)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(CreditCell.self)
    }
    
    func bindViewModel() {
        self.viewModel
            .getCredits()
            .asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: CreditCell.reuseIdentifier,
                                                   cellType: CreditCell.self)) { _, data, cell in
                                                    cell.viewModel = Variable<CreditModel>(data)
            }.disposed(by: disposeBag)
        
        self.collectionView.rx.modelSelected(CreditModel.self)
            .subscribe(onNext: { [weak self] credit in
                if let price = credit.price, let numberOfCredit = credit.numberOfCredits {
                    self?.makePayment(price: price, numberOfCredit: numberOfCredit)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CreditsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 60)
    }
}

extension CreditsVC: PKPaymentAuthorizationViewControllerDelegate {
    // MARK: - Apple Pay Delegate Methods
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        logger.log(.debug, "Authorization Finished")
        controller.dismiss(animated: true, completion: nil)
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didSelect paymentMethod: PKPaymentMethod,
                                            handler completion: @escaping (PKPaymentRequestPaymentMethodUpdate) -> Void) {
        logger.log(.debug, "Payment Method Updated")
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didAuthorizePayment payment: PKPayment,
                                            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        logger.log(.debug, "Payment Was Authorized")
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    func paymentAuthorizationViewControllerWillAuthorizePayment(_ controller: PKPaymentAuthorizationViewController) {
        logger.log(.debug, "Payment is being authorized.")
    }
}

extension CreditsVC {
    func itemToSell(amount: Double, label: Int) -> [PKPaymentSummaryItem] {
        let totalPrice = PKPaymentSummaryItem(label: "\(label) \(L10n.Credit.title)",
            amount: NSDecimalNumber(string: "\(amount)"))
        return [totalPrice]
    }
    
    func makePayment(price: Double, numberOfCredit: Int) {
        logger.log(.debug, "credit price: \(price) & number of credits: \(numberOfCredit)")
        let paymentNetworks = [PKPaymentNetwork.visa, .masterCard]
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let paymentRequest = PKPaymentRequest()
            paymentRequest.currencyCode = Constants.currencyCode
            paymentRequest.countryCode = Constants.countryCode
            paymentRequest.merchantIdentifier = Constants.merchantId
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.supportedNetworks = paymentNetworks
            paymentRequest.requiredShippingContactFields = []
            paymentRequest.paymentSummaryItems = self.itemToSell(amount: price, label: numberOfCredit)
            paymentRequest.shippingMethods = .none
            
            let applePayVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            applePayVC?.delegate = self
            self.present(applePayVC!, animated: true, completion: nil)
        } else {
            LocalNotificationView.shared.showWarning(L10n.Common.warning, body: L10n.Applepay.setAccount)
        }
    }
}

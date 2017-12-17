//
//  ControlCreditsVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 5.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class ControlCreditsVC: BaseViewController {
    
    var viewModel: ControlCreditsVMType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addCreditButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.bindViewModel()
        self.bindAlertView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
        let layout = UICollectionViewFlowLayout()
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
    }
    
    func bindAlertView() {
        let setPlaceholder: (String?) -> (UITextField) -> Void = { placeholder in {
            $0.placeholder = placeholder
            $0.keyboardType = .decimalPad
            }
        }
        
        self.addCreditButton.rx.tap
            .flatMap { [unowned self] in
                UIAlertController.rx
                    .presented(
                        by: self,
                        title: L10n.Credit.title,
                        message: L10n.Credit.addCredit,
                        actions: [AlertAction.ok, AlertAction.cancel],
                        textFields: [setPlaceholder(L10n.Credit.numberOfCredit),
                                     setPlaceholder(L10n.Credit.price)]
                )
            }
            .subscribe(onNext: { action, texts in
                switch action {
                case .ok:
                    var numberOfCredit = 0
                    var price = 0.0
                    texts?.enumerated().forEach {
                        print("\($0.offset): \($0.element ?? "nil")")
                        if $0.offset == 0 {
                            numberOfCredit = $0.element.map { value -> Int in
                                return Int(value) ?? 0
                            }!
                        } else {
                            price = $0.element.map { value -> Double in
                                return Double(value) ?? 0.0
                            }!
                        }
                    }
                    var credit = CreditModel()
                    credit.numberOfCredits = numberOfCredit
                    credit.price = price
                    self.addCredit(credit: credit)
                case .cancel: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addCredit(credit: CreditModel) {
        self.viewModel.addCredit(credit: credit) { result in
            if let result = result {
                if result {
                    LocalNotificationView.shared.showSuccess(L10n.Common.great, body: L10n.Credit.addSuccess)
                } else {
                    LocalNotificationView.shared.showError(L10n.Common.error, body: L10n.Credit.addError)
                }
            }
        }
    }
}

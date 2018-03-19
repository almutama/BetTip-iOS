//
//  ControlCreditsVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 5.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ControlCreditsVC: BaseViewController {
    
    var viewModel: ControlCreditsVMType!
    private let disposeBag = DisposeBag()
    private let selectedCredit = Variable<CreditModel?>(nil)
    
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
        
        self.collectionView
            .rx
            .modelSelected(CreditModel.self)
            .flatMap { (credit) -> ControlEvent<SheetAction> in
                self.selectedCredit.value = credit
                return UIAlertController.rx
                    .presented(
                        by: self,
                        title: L10n.Auth.logout,
                        message: L10n.Auth.confirmLogout,
                        preferredStyle: UIAlertControllerStyle.actionSheet,
                        actions: [SheetAction.update, SheetAction.delete, SheetAction.cancel],
                        animated: true
                )
            }
            .flatMap { [weak self] (action) -> Observable<Bool> in
                guard let `self` = self else { return Observable.empty() }
                switch action {
                case .update:
                    return self.updateCredit()
                case .delete:
                    return self.deleteCredit()
                case .cancel:
                    return Observable.empty()
                }
            }
            .subscribe(onNext: {result in
                self.show(result: result)
            })
            .disposed(by: disposeBag)
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
                    self.addCredit(credit: self.convertTextsAsCredit(texts: texts))
                case .cancel: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addCredit(credit: CreditModel) {
        self.viewModel.addCredit(credit: credit) { result in
            if let result = result {
                self.show(result: result)
            }
        }
    }
    
    func updateCredit() -> Observable<Bool> {
        guard let credit = self.selectedCredit.value,
            let price = credit.price,
            let numberOfCredit = credit.numberOfCredits else {
            return Observable.empty()
        }
        let setNumOfCredits: (String, Int) -> (UITextField) -> Void = { placeholder, text in {
            $0.placeholder = placeholder
            $0.text = String(describing: text)
            $0.keyboardType = .decimalPad
            }
        }
        let setPrice: (String, Double) -> (UITextField) -> Void = { placeholder, text in {
            $0.placeholder = placeholder
            $0.text = String(describing: text)
            $0.keyboardType = .decimalPad
            }
        }
        return UIAlertController.rx
            .presented(
                by: self,
                title: L10n.Credit.title,
                message: L10n.Credit.updateCredit,
                actions: [AlertAction.ok, AlertAction.cancel],
                textFields: [setNumOfCredits(L10n.Credit.numberOfCredit, numberOfCredit),
                             setPrice(L10n.Credit.price, price)]
            ).flatMap { [weak self] (action, texts) -> Observable<Bool> in
                guard let `self` = self else { return Observable.empty() }
                switch action {
                case .ok:
                    return self.viewModel.updateCredit(credit: self.convertTextsAsCredit(texts: texts, withId: credit.id))
                case .cancel:
                    return Observable.empty()
                }
        }
    }
    
    func deleteCredit() -> Observable<Bool> {
        guard let credit = self.selectedCredit.value else {
            return Observable.empty()
        }
        return self.viewModel.deleteCredit(credit: credit)
    }
    
    func show(result: Bool) {
        if result {
            LocalNotificationView.shared.showSuccess(L10n.Common.great, body: L10n.Common.Process.success)
        } else {
            LocalNotificationView.shared.showError(L10n.Common.sorry, body: L10n.Common.Process.error)
        }
    }
    
    func convertTextsAsCredit(texts: [String?]?, withId id: String? = nil) -> CreditModel {
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
                    print(value)
                    return Double(value) ?? 0.0
                }!
            }
        }
        var credit = CreditModel()
        credit.numberOfCredits = numberOfCredit
        credit.price = price
        if let id = id {
            credit.id = id
        }
        return credit
    }
}

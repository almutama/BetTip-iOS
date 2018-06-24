//
//  UserVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserVC: BaseViewController {
    
    var viewModel: UserVMType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var logoutButton: StyledButton!
    @IBOutlet weak var mailLbl: StyledLabel!
    @IBOutlet weak var currentCreditLbl: StyledLabel!
    @IBOutlet weak var usedCreditLbl: StyledLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindViewModel() {
        self.viewModel.getUser()
            .asObservable()
            .subscribe(onNext: {[weak self] user in
                guard let profile = user,
                    let mail = profile.email else {
                        self?.mailLbl.text = "-"
                        self?.usedCreditLbl.text = "-"
                        self?.currentCreditLbl.text = "-"
                        return
                }
                self?.mailLbl.text = mail
                guard let credit = profile.userCredit,
                    let usedCredit = credit.usedCredit,
                    let currentCredit = credit.currentCredit else {
                        self?.usedCreditLbl.text = "-"
                        self?.currentCreditLbl.text = "-"
                        return
                }
                self?.usedCreditLbl.text = "\(usedCredit)"
                self?.currentCreditLbl.text = "\(currentCredit)"
            }).disposed(by: self.disposeBag)
        
        self.logoutButton.rx.tap
            .flatMap { [unowned self] in
                UIAlertController.rx
                    .presented(
                        by: self,
                        title: L10n.Auth.logout,
                        message: L10n.Auth.confirmLogout,
                        actions: [AlertAction.ok, AlertAction.cancel]
                )
            }.subscribe(onNext: { action in
                switch action {
                case .ok:
                    self.viewModel.logout { result in
                        if result {
                            BGDidLogoutEvent().send()
                        } else {
                            LocalNotificationView.shared.showError(L10n.Common.error, body: L10n.Common.tryAgainLater)
                        }
                    }
                case .cancel: break
                }
            })
            .disposed(by: disposeBag)
        
        self.viewModel.userCredit()
            .asObservable()
            .map { String($0.0) }
            .bind(to: self.currentCreditLbl.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.userCredit()
            .asObservable()
            .map { String($0.1) }
            .bind(to: self.usedCreditLbl.rx.text)
            .disposed(by: disposeBag)
    }
    
    func prepareUI() {
        self.navigationItem.title = "FIRSAT BAHİS"
        self.logoutButton.layer.cornerRadius = 5
        self.logoutButton.clipsToBounds = true
    }
}

extension UserVC: Theming {
    var theme: ThemeType {
        return ThemeManager.shared.currentTheme
    }
    
    func apply() {
        
    }
}

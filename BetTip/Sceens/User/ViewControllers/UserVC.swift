//
//  UserVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class UserVC: BaseViewController {
    
    var viewModel: UserVM!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var logoutButton: StyledButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindViewModel() {
        self.viewModel.getUser()
        self.viewModel.userModel.asObservable().subscribe(onNext: {[weak self] (_) in
            self?.prepareUI()
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

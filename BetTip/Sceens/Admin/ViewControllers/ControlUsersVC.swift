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
    private let selectedUser = Variable<UserModel?>(nil)
    
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
        
        self.collectionView
            .rx
            .modelSelected(UserModel.self)
            .flatMap { (user) -> ControlEvent<UserAction> in
                self.selectedUser.value = user
                return UIAlertController.rx
                    .presented(
                        by: self,
                        title: L10n.User.Action.title,
                        message: L10n.User.Action.desc,
                        preferredStyle: UIAlertController.Style.actionSheet,
                        actions: [UserAction.userDisabled(!user.disabled), UserAction.userRole, UserAction.cancel],
                        animated: true
                )
            }
            .flatMap { [weak self] (action) -> Observable<Bool> in
                guard let `self` = self else { return Observable.empty() }
                switch action {
                case .userDisabled:
                    return self.userDisabled()
                case .userRole:
                    return self.userRole()
                case .cancel:
                    return Observable.empty()
                }
            }
            .subscribe(onNext: {result in
                self.show(result: result)
            })
            .disposed(by: disposeBag)
    }
    
    func userDisabled() -> Observable<Bool> {
        guard let user = self.selectedUser.value else {
            return Observable.empty()
        }
        return UIAlertController.rx
            .presented(
                by: self,
                title: L10n.Common.sure,
                message: L10n.User.Action.desc,
                actions: [AlertAction.ok, AlertAction.cancel]
            ).flatMap { [weak self] action -> Observable<Bool> in
                guard let `self` = self else { return Observable.empty() }
                switch action {
                case .ok:
                    return self.viewModel.disableUser(user: user, disabled: !user.disabled )
                case .cancel:
                    return Observable.empty()
                }
        }
    }
    
    func userRole() -> Observable<Bool> {
        guard let user = self.selectedUser.value else {
            return Observable.empty()
        }
        return UIAlertController.rx
            .presented(
                by: self,
                title: L10n.User.Role.title,
                message: L10n.User.Role.changeRole,
                preferredStyle:UIAlertController.Style.actionSheet,
                actions: [UserRoleAction.user, UserRoleAction.moderator, UserRoleAction.admin, UserRoleAction.cancel],
                animated: true
            ).flatMap { [weak self] action -> Observable<Bool> in
                guard let `self` = self else { return Observable.empty() }
                switch action {
                case .user:
                    return self.viewModel.changeUserRole(user: user, role: Role.user)
                case .moderator:
                    return self.viewModel.changeUserRole(user: user, role: Role.moderator)
                case .admin:
                    return self.viewModel.changeUserRole(user: user, role: Role.admin)
                case .cancel:
                    return Observable.empty()
                }
        }
    }
    
    func show(result: Bool) {
        if result {
            LocalNotificationView.shared.showSuccess(L10n.Common.great, body: L10n.Common.Process.success)
        } else {
            LocalNotificationView.shared.showError(L10n.Common.sorry, body: L10n.Common.Process.error)
        }
    }
}

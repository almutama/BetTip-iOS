//
//  UserAction.swift
//  BetTip
//
//  Created by Haydar Karkin on 4.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

enum UserAction {
    case cancel
    case userDisabled(Bool)
    case userRole
}

extension UserAction: AlertActionType {
    
    var title: String {
        switch self {
        case .cancel:
            return L10n.Common.cancel
        case .userDisabled(let isDisabled):
            return isDisabled ? L10n.User.Role.disable : L10n.User.Role.enable
        case .userRole:
            return L10n.User.Role.changeRole
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .cancel:
            return .cancel
        case .userDisabled, .userRole:
            return .default
        }
    }
    
    // Optional
    var isEnabled: Bool {
        return true
    }
    
}

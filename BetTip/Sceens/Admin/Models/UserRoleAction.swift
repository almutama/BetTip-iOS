//
//  UserRoleAction.swift
//  BetTip
//
//  Created by Haydar Karkin on 5.01.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

enum UserRoleAction {
    case cancel
    case user
    case moderator
    case admin
}

extension UserRoleAction: AlertActionType {
    
    var title: String {
        switch self {
        case .cancel:
            return L10n.Common.cancel
        case .user:
            return L10n.User.Role.user
        case .moderator:
            return L10n.User.Role.moderator
        case .admin:
            return L10n.User.Role.admin
        }
    }
    
    var style: UIAlertActionStyle {
        switch self {
        case .cancel:
            return .cancel
        case .user, .moderator, .admin:
            return .default
        }
    }
    
    // Optional
    var isEnabled: Bool {
        return true
    }
    
}

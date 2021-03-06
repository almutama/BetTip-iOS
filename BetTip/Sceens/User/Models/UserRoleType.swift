//
//  UserRole.swift
//  BetTip
//
//  Created by Haydar Karkin on 24.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

enum Role {
    case user
    case moderator
    case admin
}

extension Role {
    
    static var allRoles: [Role] {
        return [.user, .moderator, .admin]
    }
    
    var localizedName: String {
        switch self {
        case .user:
            return L10n.User.Role.user
        case .moderator:
            return L10n.User.Role.moderator
        case .admin:
            return L10n.User.Role.admin
        }
    }
}

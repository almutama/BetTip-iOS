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
    case update
    case delete
}

extension UserAction: AlertActionType {
    
    var title: String {
        switch self {
        case .cancel:
            return L10n.Common.cancel
        case .update:
            return L10n.Common.update
        case .delete:
            return L10n.Common.delete
        }
    }
    
    var style: UIAlertActionStyle {
        switch self {
        case .cancel:
            return .cancel
        case .update:
            return .default
        case .delete:
            return .default
        }
    }
    
    // Optional
    var isEnabled: Bool {
        return true
    }
    
}


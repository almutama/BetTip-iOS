//
//  AlertAction.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

enum AlertAction {
    case cancel
    case ok
}

extension AlertAction: AlertActionType {
    
    var title: String {
        switch self {
        case .cancel:
            return L10n.Common.cancel
        case .ok:
            return L10n.Common.ok
        }
    }
    
    var style: UIAlertActionStyle {
        switch self {
        case .cancel:
            return .cancel
        case .ok:
            return .default
        }
    }
    
    // Optional
    var isEnabled: Bool {
        return true
    }
    
}

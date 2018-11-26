//
//  SheetAction.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

enum SheetAction {
    case cancel
    case update
    case delete
}

extension SheetAction: AlertActionType {
    
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
    
    var style: UIAlertAction.Style {
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

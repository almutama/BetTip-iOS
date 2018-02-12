//
//  MatchAction.swift
//  BetTip
//
//  Created by Haydar Karkin on 12.02.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

enum MatchAction {
    case cancel
    case basketball
    case football
}

extension MatchAction: AlertActionType {
    
    var title: String {
        switch self {
        case .cancel:
            return L10n.Common.cancel
        case .basketball:
            return L10n.Match.basketball
        case .football:
            return L10n.Match.football
        }
    }
    
    var style: UIAlertActionStyle {
        switch self {
        case .cancel:
            return .cancel
        case .basketball, .football:
            return .default
        }
    }
    
    // Optional
    var isEnabled: Bool {
        return true
    }
}

//
//  CouponActions.swift
//  BetTip
//
//  Created by Haydar Karkin on 13.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

enum CouponAction {
    case cancel
    case buy(coupon: CouponModel)
}

extension CouponAction: AlertActionType {
    
    var title: String {
        switch self {
        case .cancel:
            return L10n.Common.cancel
        case .buy:
            return L10n.Common.buy
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .cancel:
            return .cancel
        case .buy:
            return .default
        }
    }
    
    // Optional
    var isEnabled: Bool {
        return true
    }
    
}

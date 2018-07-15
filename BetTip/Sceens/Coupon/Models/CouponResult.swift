//
//  CouponResult.swift
//  BetTip
//
//  Created by Haydar Karkin on 24.06.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

enum CouponResultAction {
    case openCoupon(coupon: CouponModel)
    case buyCoupon
}

struct CouponResult {
    var result: Bool = false
    var resultAction: CouponResultAction = .buyCoupon
    
    init(result: Bool, resultAction: CouponResultAction) {
        self.result = result
        self.resultAction = resultAction
    }
}

//
//  Double+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 13.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

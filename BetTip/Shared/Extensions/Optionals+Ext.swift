//
//  Optionals+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 13.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

infix operator ==? : ComparisonPrecedence

func ==? <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

func ==? <T: AnyObject>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs === rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

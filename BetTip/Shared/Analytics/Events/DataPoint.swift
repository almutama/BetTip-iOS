//
//  DataPoint.swift
//  BetTip
//
//  Created by Haydar Karkin on 15.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

/// Allows us to use events with dynamic information (e.g. data points)
public struct DataPoint {
    let name: String
    let value: Any?
    
    func toString() -> String {
        // Avoid "(Optional)" string:
        var stringBuilder = "\'"
        stringBuilder.append(name)
        stringBuilder.append("\':\'")
        if let value = self.value {
            stringBuilder.append(String(describing: value))
        }
        stringBuilder.append("\'")
        
        return stringBuilder
    }
}

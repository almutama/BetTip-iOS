//
//  Event.swift
//  BetTip
//
//  Created by Haydar Karkin on 15.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

/// Base class for events aka Default Event
public class Event: NSObject {
    
    final let category: Category          // category of the event
    final let name: String                // name of the event
    final var dataPoints: [DataPoint]     // allow us to "mark" events with dynamic information (e.g. data points)
    
    /// Default initializer
    ///
    /// - Parameters:
    ///   - category: Event category
    ///   - name: Event name
    ///   - dataPoints: Variadic parameter - a set of DataPoint objects
    init(category: Category, name: String, dataPoints: DataPoint...) {
        self.category = category
        self.name = name
        self.dataPoints = dataPoints
    }
    
    /// Initializer could be used when there is no DataPoint objects to log
    ///
    /// - Parameters:
    ///   - category: Event category
    ///   - name: Event name
    init(category: Category, name: String) {
        self.category = category
        self.name = name
        self.dataPoints = []
    }
    
    func toString() -> String {
        return "<" + self.category.rawValue + "::" + self.name + ">"
    }
    
    /// Generates formatted string from Datapoints array
    ///
    /// - Returns: string formatted "{datapointA,datapointB}" or just "{}" for empty array
    func datapointsToFormattedString() -> String {
        // build
        var stringBuilder = "{"
        var separator = ""
        for aDatapoint in self.dataPoints {
            stringBuilder.append(separator)
            stringBuilder.append(aDatapoint.toString())
            separator = ","
        }
        stringBuilder.append("}")
        return stringBuilder
    }
}

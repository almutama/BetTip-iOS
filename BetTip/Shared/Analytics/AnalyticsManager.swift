//
//  AnalyticsManager.swift
//  BetTip
//
//  Created by Haydar Karkin on 15.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

/// Any analytics library should conform to this protocol
protocol AnalyticsServiceProtocol: class {
    
    /// Records a specific event
    ///
    /// - Parameter event: the Event to record
    func record(event: Event)
}

/// Main class for logging events
class AnalyticsManager: NSObject {
    
    /// Singleton
    static let sharedManager = AnalyticsManager()
    
    /// A list of analytics providers
    private var analyticsServices = [AnalyticsServiceProtocol]()
    
    /// Hidden initializer
    private override init () {
        // initialization here
    }
    
    /// Registers analytics service provider
    ///
    /// - Parameter newService: object, which conforms to AnalyticsServiceProtocol
    func register(newService: AnalyticsServiceProtocol) {
        analyticsServices.append(newService)
    }
    
    /// Records a specific event
    ///
    /// - Parameter event: the Event to record
    func record(event: Event) {
        for aService in analyticsServices {
            aService.record(event: event)
        }
    }
}

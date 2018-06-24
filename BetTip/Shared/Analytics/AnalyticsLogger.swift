//
//  AnalyticsLogger.swift
//  BetTip
//
//  Created by Haydar Karkin on 15.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

private let logger = Log.createLogger()

class AnalyticsLogger: AnalyticsServiceProtocol {
    
    func record(event: Event) {
        // format: "Logging Event: {} with datapoints: {}" event.name, datapoints
        let datapointLabelString = event.datapointsToFormattedString()
        let logString = "Logging Event: {\(event.name)} with datapoints: \(datapointLabelString))"
        
        logger.log(.verbose, logString)
    }
}

//
//  ErrorEvent.swift
//  BetTip
//
//  Created by Haydar Karkin on 15.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

/// Class for registering errors
class ErrorEvent: Event {
    
    /// Detects is it an NSException or just an Error(NSError)
    let isException: Bool
    
    /// Creates ErrorEvent objects from given Error(NSError) object
    /// Also, ErrorEvent will grab some debug info when created: filename, function name, line
    ///
    /// - Parameters:
    ///   - error: Error(NSError) object
    ///   - file: Hidden, filename macros
    ///   - function: Hidden, function name macros
    ///   - line: Hidden, line number macros
    init(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        isException = false
        // create DataPoint with Error name and error's object
        let errorData = DataPoint(name: String(describing: type(of: error)), value: error)
        // Attaching some debug info: where this event has been created (filename, function, line)
        let errorLocationString = "file:\((file as NSString).lastPathComponent) function:\(function) line:\(line)"
        let debugData = DataPoint(name: Constants.errorEventDebugInfoDatapoint, value: errorLocationString)
        // initialize as OnError event
        super.init(category: Category.OnError, name: Constants.errorEventName, dataPoints: errorData, debugData)
    }
    
    /// Creates ErrorEvent objects from given NSException object
    ///
    /// - Parameter error: NSException object
    init(exception: NSException) {
        isException = true
        // create DataPoint with Exception name and exception stack trace
        let exceptionDescription = DataPoint(name: Constants.exceptionDescriptionDatapointName, value: exception.description)
        let callStackSymbols = DataPoint(name: Constants.exceptionTraceDatapointName, value: exception.callStackSymbols.description)
        // initialize as OnError event
        super.init(category: Category.OnError, name: Constants.exceptionEventName, dataPoints: exceptionDescription, callStackSymbols)
    }
    
    /// Creates ErrorEvent objects from given String object
    ///
    /// - Parameter message: provide your own description of the error
    init(message: String) {
        isException = false
        let dataPoint = DataPoint(name: Constants.errorEventDebugInfoDatapoint, value: message)
        super.init(category: Category.OnError, name: Constants.errorEventName, dataPoints: dataPoint)
    }
}

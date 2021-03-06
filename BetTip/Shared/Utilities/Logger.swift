//
//  Logger.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import CocoaLumberjack
import Foundation
import PaperTrailLumberjack

class Log {
    static var isOn = true
    
    static func createLogger() -> Logger {
        if isOn {
            return LumberJackLogger()
        }
        return NoopLogger()
    }
}

#if DEBUG || ADHOC
    private let ddLogLevel = DDLogLevel.debug
#else
    private let ddLogLevel = DDLogLevel.info
#endif

private var once = Int()
private class LumberJackLogger: Logger {
    
    private static var __once: () = {
        if DebugDetector.debuggerAttached() {
            DDTTYLogger.sharedInstance.logFormatter = LumberJackFormatter()
            DDLog.add(DDTTYLogger.sharedInstance, with: ddLogLevel)
        }
        
        if let paperTrailLogger = RMPaperTrailLogger.sharedInstance(), !DebugDetector.debuggerAttached() {
            DDASLLogger.sharedInstance.logFormatter = LumberJackFormatter()
            DDLog.add(DDASLLogger.sharedInstance, with: ddLogLevel)
            
            paperTrailLogger.host = "logs6.papertrailapp.com"
            paperTrailLogger.port = 10007
            paperTrailLogger.useTLS = true
            let deviceUUID = UserVariableProvider().deviceUUID
            let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String ?? ""
            let displayName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String ?? ""
            let nameToUse = displayName.isEmpty ? appName : displayName
            let appShortVersion  = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
            let appLongVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""
            let appVersion = "\(appShortVersion)-\(appLongVersion)"
            paperTrailLogger.logFormatter = PaperTrailFormatter(deviceUUID: deviceUUID, appName: nameToUse, appVersion: appVersion)
            DDLog.add(paperTrailLogger, with: ddLogLevel)
        }
    }()
    
    init() {
        _ = LumberJackLogger.__once
    }
    
    func writeLogEntry(_ logLevel: DDLogLevel, _ message: @autoclosure () -> String, file: StaticString, line: UInt, function: StaticString) {
        switch logLevel {
        case .error:
            DDLogError(message, level: logLevel, file: file, function: function, line: line)
        case .warning:
            DDLogWarn(message, level: logLevel, file: file, function: function, line: line)
        case .info:
            DDLogInfo(message, level: logLevel, file: file, function: function, line: line)
        case .debug:
            DDLogDebug(message, level: logLevel, file: file, function: function, line: line)
        case .verbose:
            DDLogVerbose(message, level: logLevel, file: file, function: function, line: line)
        default:
            break
        }
    }
    
}

private class LumberJackFormatter: NSObject, DDLogFormatter {
    /**
     * Formatters may optionally be added to any logger.
     * This allows for increased flexibility in the logging environment.
     * For example, log messages for log files may be formatted differently than log messages for the console.
     *
     * For more information about formatters, see the "Custom Formatters" page:
     * Documentation/CustomFormatters.md
     *
     * The formatter may also optionally filter the log message by returning nil,
     * in which case the logger will not log the message.
     **/
    public func format(message logMessage: DDLogMessage) -> String? {
        return "[\(dateFormater.string(from: logMessage.timestamp)) \(logMessage.fileName).\(logMessage.function!):\(logMessage.line)] \(logMessage.level.symbol)\(logMessage.level): \((logMessage.message))"
        
    }
    
    let dateFormater: DateFormatter
    
    override init() {
        dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
    }
    
}

private class PaperTrailFormatter: NSObject, DDLogFormatter {
    /**
     * Formatters may optionally be added to any logger.
     * This allows for increased flexibility in the logging environment.
     * For example, log messages for log files may be formatted differently than log messages for the console.
     *
     * For more information about formatters, see the "Custom Formatters" page:
     * Documentation/CustomFormatters.md
     *
     * The formatter may also optionally filter the log message by returning nil,
     * in which case the logger will not log the message.
     **/
    public func format(message logMessage: DDLogMessage) -> String? {
        return "<22>1 2014-06-18T09:56:21Z \(appName)-iOS \(deviceUUID) - - - \(appVersion) [\((logMessage.fileName ))] \(logMessage.level): \((logMessage.message))"
    }
    
    let dateFormater: DateFormatter
    let deviceUUID: String
    let appName: String
    let appVersion: String
    
    init(deviceUUID: String, appName: String, appVersion: String) {
        self.appVersion = appVersion
        self.deviceUUID = deviceUUID
        self.appName = appName
        dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
    }
    
}

extension DDLogLevel: CustomStringConvertible {
    public var description: String {
        var desc = ""
        switch self {
        case .error:
            desc = "error"
        case .warning:
            desc = "warning"
        case .info:
            desc = "info"
        case .debug:
            desc = "debug"
        case .verbose:
            desc = "verbose"
        case .all:
            desc = "all"
        case .off:
            desc = "off"
        }
        return desc.uppercased()
    }
    
    public var symbol: String {
        switch self {
        case .error:
            return "‼️ "
        case .warning:
            return "⚠️ "
        case .info:
            return "ℹ️ "
        case .debug:
            return "🎃 "
        case .verbose:
            return "💬 "
        case .all:
            return ""
        case .off:
            return ""
        }
    }
}

protocol Logger {
    func writeLogEntry(_ logLevel: DDLogLevel, _ message: @autoclosure () -> String, file: StaticString, line: UInt, function: StaticString)
}

extension Logger {
    /// The public API for `Logger`. Calls
    /// `writeLogEntry(_:,_:,file:,line:,function:)`.
    func log(_ logLevel: DDLogLevel, _ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {
        writeLogEntry(logLevel, message, file: file, line: line, function: function)
    }
}

private class NoopLogger: Logger {
    func writeLogEntry(_ logLevel: DDLogLevel, _ message: @autoclosure () -> String, file: StaticString, line: UInt, function: StaticString) { }
}

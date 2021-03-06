//
//  Date+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 8.03.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

extension Date {
    func dateWithFormat(dateFormat format: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "dd:MM:yyyy HH:mm"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func monthInt() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let monthString = dateFormatter.string(from: self)
        return Int(monthString)!
    }
    
    static func fromUTC(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: format)
    }
    
    static func toUTC(from: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: from)
    }
    
    static func currentTimeInMillis() -> TimeInterval {
        return Date().timeIntervalSince1970 * 1000
    }
    
    var day: Int { return Calendar.current.component(.day, from: self) }
    var month: Int { return Calendar.current.component(.month, from: self) }
    var year: Int { return Calendar.current.component(.year, from: self) }
}

extension NSDate {
    static func oneHourFromNow() -> NSDate {
        return NSDate.hoursFormNow(numberOfHours: 1)
    }
    
    static func hoursFormNow(numberOfHours: Int) -> NSDate {
        let interval = Double(numberOfHours) * 60
        return NSDate().addingTimeInterval(interval)
    }
}

extension TimeInterval {
    static var second: TimeInterval { return 1 }
    static var minute: TimeInterval { return second * 60 }
    static var hour: TimeInterval { return minute * 60 }
    static var day: TimeInterval { return hour * 24 }
    static var week: TimeInterval { return day * 7 }
    static var month: TimeInterval { return day * 30 }
    static var year: TimeInterval { return day * 365 }
}

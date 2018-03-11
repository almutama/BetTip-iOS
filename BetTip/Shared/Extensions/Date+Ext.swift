//
//  Date+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 8.03.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

extension Date {
    func dateWithFormat() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:MM:yyyy HH:mm"//29:01:2015 16:31
        let dateInFormat = dateFormatter.string(from: todaysDate as Date)
        return dateInFormat
    }
    
    func monthInt() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let monthString = dateFormatter.string(from: self)
        return Int(monthString)!
    }
    
    static func fromUTC(format:String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: format)
    }
    
    static func toUTC(from:Date) -> String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: from)
    }
    
    static func currentTimeInMillis() -> TimeInterval {
        return Date().timeIntervalSince1970 * 1000
    }
    
    var day:Int {return Calendar.current.component(.day, from:self)}
    var month:Int {return Calendar.current.component(.month, from:self)}
    var year:Int {return Calendar.current.component(.year, from:self)}
}

//
//  String+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

extension String {
    
    static func className(_ obj: AnyObject) -> String {
        return String(describing: obj.self).components(separatedBy: ".").last!
    }
    
    static func className(_ cls: AnyClass) -> String {
        return String(describing: cls).components(separatedBy: ".").last!
    }
    
    func nilIfEmpty() -> String? {
        return self == "" ? nil : self
    }
    
    func stringByReplacingCharactersInNSRange(_ range: NSRange, replacementString string: String) -> String {
        return String(NSString(string: self).replacingCharacters(in: range, with: string))
    }
    
    var prettifiedString: String {
        let separatorCharacterSet = CharacterSet(charactersIn: "-_ ")
        return self.components(separatedBy: separatorCharacterSet).joined(separator: " ").capitalized
    }
    
    func URLEncodedString() -> String? {
        let customAllowedSet =  CharacterSet.urlQueryAllowed
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        return escapedString
    }
    
    func firstCharIsADigit() -> Bool {
        guard let firstChar = self.first else { return false }
        
        let s = String(firstChar).unicodeScalars
        let uni = s[s.startIndex]
        
        let digits = CharacterSet.decimalDigits
        return digits.contains(UnicodeScalar(uni.value)!)
    }
    
    func removeLeadingCharcters(forNPlaces places: Int) -> String {
        guard places > 0  else { return self }
        guard places < self.count else { return "" }
        let range = self.index(self.startIndex, offsetBy: places)..<self.endIndex
        return String(self[range])
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(withComment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
    
    /// Truncates String to given langth
    ///
    /// - Parameter length: Result string will be limited to the given number of characters.
    /// If length is 0 or less - empty string will be returned
    /// - Returns: truncated string.
    func truncateToLength(_ length: Int) -> String {
        if length <= 0 {
            // returns empty string
            return ""
        } else if length < self.count {
            let endIndex = self.index(self.startIndex, offsetBy: length)
            let truncatedString = self[...endIndex]
            return String(truncatedString)
        } else {
            return self
        }
    }
    
}

extension String {
    
    func dateValue(with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

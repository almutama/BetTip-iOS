//
//  String+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

extension String {
    func nilIfEmpty() -> String? {
        return self == "" ? nil : self
    }
    
    func stringByReplacingCharactersInNSRange(_ range: NSRange, replacementString string: String) -> String {
        return String(NSString(string: self).replacingCharacters(in: range, with: string))
    }
    
    func truncate(_ length: Int) -> String {
        let punctuationToRemoveSet = CharacterSet(charactersIn: ",.?!;:")
        if count > length {
            var stringArray = self.substring(to: index(startIndex, offsetBy: length)).components(separatedBy: " ")
            stringArray.removeLast()
            let last = stringArray.removeLast().components(separatedBy: punctuationToRemoveSet).joined(separator: "")
            stringArray.append(last)
            return stringArray.joined(separator: " ") + "..."
        } else {
            return self
        }
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
    
    func localized(withComment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
    
}

extension String {
    
    func dateValue(with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0) //TODO: (JA) talk to API folks about time zones on timestamps
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

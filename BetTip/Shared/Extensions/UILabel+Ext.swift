//
//  UILabel+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 13.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

extension UILabel {
    func coloredText (fullText: String, changeText: String, color: UIColor) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        self.attributedText = attribute
    }
}

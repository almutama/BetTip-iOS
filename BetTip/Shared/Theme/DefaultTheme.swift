//
//  DefaultTheme.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

class DefaultTheme: ThemeType {
    // fonts
    var header1Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 100), lineHeight: 125, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var header2Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 44), lineHeight: 48, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var header3Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 35), lineHeight: 40, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var header4Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 24), lineHeight: 30, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var header4Book: Style {
        return Style(font: UIFont.systemFont(ofSize: 24), lineHeight: 30, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var body1Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 20), lineHeight: 26, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var body1Book: Style {
        return Style(font: UIFont.systemFont(ofSize: 20), lineHeight: 26, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var body2Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 15), lineHeight: 20, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var body2Book: Style {
        return Style(font: UIFont.systemFont(ofSize: 15), lineHeight: 20, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var body3Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 12), lineHeight: 14, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var body3Book: Style {
        return Style(font: UIFont.systemFont(ofSize: 12), lineHeight: 14, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var notification1Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 10), lineHeight: 12, kerning: 1, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var button1Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 15), lineHeight: 20, kerning: 1.5, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var button2Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 12), lineHeight: 14, kerning: 1.2, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    var emoji: Style {
        return Style(font: UIFont.systemFont(ofSize: 57), lineHeight: 75, kerning: 0, alignment: .center, lineBreak: .byWordWrapping, color: generalText)
    }
    
    // MARK: Colors
    // Almost dark color
    var main: UIColor { return UIColor.main }
    // Cyan color
    var secondary: UIColor { return UIColor.secondary }
    // White color
    var complementary: UIColor { return UIColor.complementary }
    
    // White color
    var generalText: UIColor { return UIColor.generalTextActive }
    // Gray color
    var secondaryText: UIColor { return UIColor.secondaryTextActive }
    // Very light gray color
    var complementaryText: UIColor { return UIColor.complementaryTextActive }
    // Orange color
    var highlight: UIColor { return UIColor.highlight }
    
    // Action Green color
    var defaultAction: UIColor { return UIColor.defaultAction }
    // Light Green Color
    var secondaryAction: UIColor { return UIColor.secondaryAction }
    // Dark Green Color
    var complementaryAction: UIColor { return UIColor.complementaryAction }
    
    // Shadow color
    var shadow: UIColor { return UIColor.black.withAlphaComponent(0.5) }
    
    // sizes
    var extraLargeRowHeight: CGFloat { return 90.0 }
    var largeRowHeight: CGFloat { return 76.0 }
    var mediumRowHeight: CGFloat { return 60.0 }
    var smallRowHeight: CGFloat { return 50.0 }
    var actionButtonHeight: CGFloat { return 76.0 }
    
    // system items
    var statusBarStyle: UIStatusBarStyle { return .default }
    var keyboardAppearance: UIKeyboardAppearance { return .default }
}

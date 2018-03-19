//
//  DefaultCompactTheme.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

final class DefaultCompactTheme: DefaultTheme {
    // fonts
    override var header1Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 84), lineHeight: 105, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var header2Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 36), lineHeight: 40, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var header3Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 30), lineHeight: 34, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var header4Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 21), lineHeight: 26, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var header4Book: Style {
        return Style(font: UIFont.systemFont(ofSize: 21), lineHeight: 26, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var body1Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 17), lineHeight: 22, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var body1Book: Style {
        return Style(font: UIFont.systemFont(ofSize: 17), lineHeight: 22, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var body2Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 13), lineHeight: 17, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var body2Book: Style {
        return Style(font: UIFont.systemFont(ofSize: 13), lineHeight: 17, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var body3Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 12), lineHeight: 14, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var body3Book: Style {
        return Style(font: UIFont.systemFont(ofSize: 12), lineHeight: 14, kerning: 0, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var notification1Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 10), lineHeight: 12, kerning: 1, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var button1Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 13), lineHeight: 17, kerning: 1.3, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var button2Bold: Style {
        return Style(font: UIFont.systemFont(ofSize: 12), lineHeight: 14, kerning: 1.2, alignment: .left, lineBreak: .byWordWrapping, color: generalText)
    }
    override var emoji: Style {
        return Style(font: UIFont.systemFont(ofSize: 48), lineHeight: 75, kerning: 0, alignment: .center, lineBreak: .byWordWrapping, color: generalText)
    }
    
    // sizes
    override var extraLargeRowHeight: CGFloat { return 76.0 }
    override var largeRowHeight: CGFloat { return 60.0 }
    override var mediumRowHeight: CGFloat { return 50.0 }
    override var smallRowHeight: CGFloat { return 44.0 }
    override var actionButtonHeight: CGFloat { return 60.0 }
    
}

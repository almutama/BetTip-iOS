//
//  Style.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

struct Style {
    var font: UIFont = .systemFont(ofSize: 12)
    var lineHeight: CGFloat = 0.0
    var kerning: CGFloat = 0.0
    var alignment: NSTextAlignment = .left
    var lineBreak: NSLineBreakMode = .byWordWrapping
    var color: UIColor = .purple
}

enum TypographyType {
    case `default`
    case `subscript`
    case superscript
}

extension Style {
    
    var attributes: [NSAttributedStringKey: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.lineBreakMode = lineBreak
        
        let attributes = [ NSAttributedStringKey.foregroundColor: color,
                           NSAttributedStringKey.kern: kerning,
                           NSAttributedStringKey.font: font,
                           NSAttributedStringKey.paragraphStyle: paragraphStyle] as [NSAttributedStringKey: Any]
        
        return attributes
    }
    
    func aligned(_ alignment: NSTextAlignment) -> Style {
        return Style(font: self.font, lineHeight: self.lineHeight, kerning: self.kerning, alignment: alignment, lineBreak: self.lineBreak, color: self.color)
    }
    
    func colored(_ color: UIColor) -> Style {
        return Style(font: self.font, lineHeight: self.lineHeight, kerning: self.kerning, alignment: self.alignment, lineBreak: self.lineBreak, color: color)
    }
    
    func kerned(_ kerning: CGFloat) -> Style {
        return Style(font: self.font, lineHeight: self.lineHeight, kerning: kerning, alignment: self.alignment, lineBreak: self.lineBreak, color: self.color)
    }
    
    func lineHeight(_ lineHeight: CGFloat) -> Style {
        return Style(font: self.font, lineHeight: lineHeight, kerning: self.kerning, alignment: self.alignment, lineBreak: self.lineBreak, color: self.color)
    }
    
    func sized(_ fontSize: CGFloat) -> Style {
        if let font = UIFont(name: self.font.fontName, size: fontSize) {
            return Style(font: font, lineHeight: self.lineHeight, kerning: self.kerning, alignment: self.alignment, lineBreak: self.lineBreak, color: color)
        }
        return self
    }
    
    func lineBreak(_ lineBreak: NSLineBreakMode) -> Style {
        return Style(font: self.font, lineHeight: self.lineHeight, kerning: self.kerning, alignment: self.alignment, lineBreak: lineBreak, color: self.color)
    }
}

extension String {
    
    func styled(with style: Style) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: style.attributes)
    }
    
    func styled(with style: Style, type: TypographyType, scale: CGFloat) -> NSAttributedString {
        let result = NSMutableAttributedString(string: self, attributes: style.attributes)
        if type != .default {
            if let range = self.range(of: " ") {
                let location: Int = self.distance(from: self.startIndex, to: range.lowerBound)
                let length: Int = self.distance(from: range.lowerBound, to: self.endIndex)
                result.addAttributes([NSAttributedStringKey.font: style.font.withSize(style.font.pointSize*scale), NSAttributedStringKey.baselineOffset: type == .subscript ? 0 : style.font.pointSize*(1-scale)], range: NSRange(location: location, length: length))
            }
        }
        return result
    }
}

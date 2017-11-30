//
//  ColorSheet.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

extension UIColor {
    
    class var main: UIColor {
        return withHex(hex: 0x2C3940)
    }
    
    class var secondary: UIColor {
        return withHex(hex: 0x43DBA8)
    }
    
    class var complementary: UIColor {
        return .white
    }
    
    class var generalTextActive: UIColor {
        return .white
    }
    
    class var secondaryTextActive: UIColor {
        return .gray
    }
    
    class var complementaryTextActive: UIColor {
        return .lightGray
    }
    
    class var highlight: UIColor {
        return withHex(hex: 0xFFFD6225)
    }
    
    class var defaultAction: UIColor {
        return withHex(hex: 0xFF4CB935)
    }
    
    class var secondaryAction: UIColor {
        return withHex(hex: 0xFF82CE71)
    }
    
    class var complementaryAction: UIColor {
        return withHex(hex: 0xFF165416)
    }
    
    class func withHex(hex: UInt) -> UIColor {
        let red = (CGFloat)((hex & 0xFF0000) >> 16) / (CGFloat)(255)
        let green = (CGFloat)((hex & 0xFF00) >> 8) / (CGFloat)(255)
        let blue = (CGFloat)(hex & 0xFF) / (CGFloat)(255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    class func fromString(colorString: String) -> UIColor {
        var rgbValue: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        return self.withHex(hex: UInt(rgbValue))
    }
    
    func image(of size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

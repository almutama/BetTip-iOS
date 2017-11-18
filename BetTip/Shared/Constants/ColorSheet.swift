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
    
    class var mainBackground: UIColor {
        return mainViolet
    }
    
    class var navbarBackground: UIColor {
        return mainViolet
    }
    
    class var navigationTint: UIColor {
        return .white
    }
    
    class var navigationTitle: UIColor {
        return .white
    }
    
    class var mainViolet: UIColor {
        return withHex(hex: 0x282828)
    }
    
    class var lightGrayViolet: UIColor {
        return withHex(hex: 0xd8d8d8)
    }
    
    
    class var fieldLabelTextInactive: UIColor {
        return withHex(hex: 0x7B7B7B)
    }
    
    class var fieldLabelTextActive: UIColor {
        return .white
    }
    
    class var fieldLabelBackgroundInactive: UIColor {
        return .white
    }
    
    class var fieldLabelBackgroundActive: UIColor {
        return mainViolet
    }
    
    class var separator: UIColor {
        return withHex(hex: 0xDEE6F2)
    }
    
    class var popupText: UIColor {
        return withHex(hex:0x474747)
    }
    
    class var navbarShadow: UIColor {
        return .mainViolet
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

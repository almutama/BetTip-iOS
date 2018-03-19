//
//  ShakeView.swift
//  BetTip
//
//  Created by Haydar Karkin on 7.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import UIKit

class ShakeViewAnimation {
    static func shake(to view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }
}

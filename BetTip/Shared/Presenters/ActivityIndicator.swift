//
//  ActivityIndicator.swift
//  BetTip
//
//  Created by Haydar Karkin on 27.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Foundation

let ActivityViewTag = 353535

class ActivityIndicator {
    
    // MARK: Initializers
    static let sharedInstance = ActivityIndicator()
    var hud: ProgressHUD!
    let window = (UIApplication.shared.delegate!.window ?? nil)! as UIWindow
    
    func show(_ status: String? = nil) -> ProgressHUD {
        return ActivityIndicator.sharedInstance.showProgress(status, center: (window.center))
    }
    
    func showProgress(_ status: String? = nil, center: CGPoint) -> ProgressHUD {
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen().screenWidth, height: UIScreen().screenHeight)
        let color = UIColor.navbarBackground
        let type = NVActivityIndicatorType.ballGridPulse
        
        let hud = ProgressHUD(frame: frame, type: type, color: color)
        hud.tag = ActivityViewTag
        hud.delegate = self
        hud.labelText = status
        
        if let view = window.viewWithTag(ActivityViewTag) as? ProgressHUD {
            view.hide(true)
        }
        window.addSubview(hud)
        hud.show(true)
        
        hud.center = center
        
        return hud
    }
    
    func hide() {
        dispatchDelayed(0.1) {
            if let hud = self.window.viewWithTag(ActivityViewTag) as? ProgressHUD {
                hud.hide(true)
            }
        }
    }
    
    fileprivate func dispatchDelayed(_ delay: Float, block: @escaping () -> Void) {
        let myDelay = Double(delay) * Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(myDelay)) / Double(NSEC_PER_SEC)) { () -> Void in
            block()
        }
    }
    
}

extension ActivityIndicator: ProgressHUDDelegate {
    
    func hudDidHidden(_ hud: ProgressHUD) {
        print(#function)
        if let view = window.viewWithTag(ActivityViewTag) as? ProgressHUD {
            view.removeFromSuperview()
        }
    }
}

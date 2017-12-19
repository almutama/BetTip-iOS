//
//  ActivityIndicator.swift
//  BetTip
//
//  Created by Haydar Karkin on 27.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import RxSwift
import RxCocoa
import Reactant

let ActivityViewTag = 353535

class ActivityIndicatorView {
    
    // MARK: Initializers
    static let sharedInstance = ActivityIndicatorView()
    var hud: ProgressHUD!
    let window = (UIApplication.shared.delegate!.window ?? nil)! as UIWindow
    
    func show(_ status: String? = nil) -> ProgressHUD {
        return ActivityIndicatorView.sharedInstance.showProgress(status, center: (window.center))
    }
    
    func showProgress(_ status: String? = nil, center: CGPoint) -> ProgressHUD {
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen().screenWidth, height: UIScreen().screenHeight)
        let color = UIColor.secondary
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

extension ActivityIndicatorView: ProgressHUDDelegate {
    
    func hudDidHidden(_ hud: ProgressHUD) {
        print(#function)
        if let view = window.viewWithTag(ActivityViewTag) as? ProgressHUD {
            view.removeFromSuperview()
        }
    }
}

let loadingIndicator: ActivityIndicator<String> = {
    let activityIndicator = ActivityIndicator<String>()
    let activityData = ActivityData(size: nil, message: nil, type: .ballSpinFadeLoader, color: UIColor.secondary, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
    
    activityIndicator.asDriver().drive(onNext: { loading, _ in
        if loading {
             NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        } else {
             NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }).disposed(by: activityIndicator.disposeBag)
    
    return activityIndicator
}()

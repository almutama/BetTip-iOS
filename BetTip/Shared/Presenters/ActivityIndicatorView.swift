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

class LoadingIndicator {
    
    static let shared = LoadingIndicator()
    let activityData = ActivityData(size: nil,
                                    message: nil,
                                    type: .ballSpinFadeLoader,
                                    color: UIColor.secondary,
                                    padding: nil,
                                    displayTimeThreshold: nil,
                                    minimumDisplayTime: nil)
    
    func show(color: UIColor? = .clear) {
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hide() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension UIViewController {
    func bindAnimateWith(variable: Variable<Bool>, color: UIColor? = UIColor.secondary) -> Disposable {
        
        return variable.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (loading) in
                if loading {
                    LoadingIndicator.shared.show(color: color)
                } else {
                    LoadingIndicator.shared.hide()
                }
            })
    }
}

let loadingIndicator: ActivityTracker = {
    let activityIndicator = ActivityTracker()
    let disposeBag = DisposeBag()
    
    activityIndicator.asDriver().drive(onNext: { loading in
        if !loading {
            LoadingIndicator.shared.show()
        } else {
            LoadingIndicator.shared.hide()
        }
    }).disposed(by: disposeBag)
    
    return activityIndicator
}()

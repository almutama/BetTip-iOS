//
//  AdMobInterstitial+Rx.swift
//  BetTip
//
//  Created by Haydar Karkin on 7.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import RxSwift
import RxCocoa

extension Reactive where Base: GADInterstitial {
    
    public var didReceiveAd: Observable<GADInterstitial> {
        let delegateProxy = RxGADInterstitialViewDelegateProxy.proxy(for: base)
        
        // swiftlint:disable force_cast
        let didReceiveAd = delegateProxy
            .methodInvoked(#selector(GADInterstitialDelegate.interstitialDidReceiveAd(_:)))
            .map { $0[0] as! GADInterstitial }
        
        let didFailToReceiveAd = delegateProxy
            .methodInvoked(#selector(GADInterstitialDelegate.interstitial(_:didFailToReceiveAdWithError:)))
            .flatMap { input -> Observable<GADInterstitial> in
                var error: NSError? = nil
                
                if input.count == 2, let inputError = input[1] as? NSError {
                    error = inputError
                }
                
                return Observable.error(error ?? NSError(domain: "", code: 0, userInfo: nil))
        }
        
        let merged = Observable.of(didReceiveAd, didFailToReceiveAd).merge().take(1).share(replay: 1)
        return merged
        // swiftlint:enable force_cast
    }
    
}

public class RxGADInterstitialViewDelegateProxy: DelegateProxy<GADInterstitial, GADInterstitialDelegate>, DelegateProxyType, GADInterstitialDelegate {
    public static func registerKnownImplementations() {
        self.register { RxGADInterstitialViewDelegateProxy(interstitialView: $0) }
    }
    
    internal init(interstitialView: GADInterstitial) {
        super.init(parentObject: interstitialView, delegateProxy: RxGADInterstitialViewDelegateProxy.self)
    }
    
    public static func currentDelegate(for object: GADInterstitial) -> GADInterstitialDelegate? {
        let interstitialView = object
        return interstitialView.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: GADInterstitialDelegate?, to object: GADInterstitial) {
        let interstitialView = object
        interstitialView.delegate = delegate as? RxGADInterstitialViewDelegateProxy
    }
}

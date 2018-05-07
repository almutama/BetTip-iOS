//
//  AdMobBanner+Rx.swift
//  BetTip
//
//  Created by Haydar Karkin on 6.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import RxSwift
import RxCocoa

extension Reactive where Base: GADBannerView {
    
    public var didReceiveAd: Observable<GADBannerView> {
        let delegateProxy = RxGADBannerViewDelegateProxy.proxy(for: base)
        
        // swiftlint:disable force_cast
        let didReceiveAd = delegateProxy
            .methodInvoked(#selector(GADBannerViewDelegate.adViewDidReceiveAd(_:)))
            .map { $0[0] as! GADBannerView }
        
        let didFailToReceiveAd = delegateProxy
            .methodInvoked(#selector(GADBannerViewDelegate.adView(_:didFailToReceiveAdWithError:)))
            .flatMap { input -> Observable<GADBannerView> in
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

public class RxGADBannerViewDelegateProxy: DelegateProxy<GADBannerView, GADBannerViewDelegate>, DelegateProxyType, GADBannerViewDelegate {
    public static func registerKnownImplementations() {
        self.register { RxGADBannerViewDelegateProxy(bannerView: $0) }
    }
    
    internal init(bannerView: GADBannerView) {
        super.init(parentObject: bannerView, delegateProxy: RxGADBannerViewDelegateProxy.self)
    }
    
    public static func currentDelegate(for object: GADBannerView) -> GADBannerViewDelegate? {
        let bannerView = object
        return bannerView.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: GADBannerViewDelegate?, to object: GADBannerView) {
        let bannerView = object
        bannerView.delegate = delegate as? RxGADBannerViewDelegateProxy
    }
}

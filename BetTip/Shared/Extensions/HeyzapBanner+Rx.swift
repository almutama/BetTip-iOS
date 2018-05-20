//
//  Heyzap+Rx.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: HZBannerAd {
    
    public var didReceiveAd: Observable<HZBannerAd> {
        let delegateProxy = RxHZBannerViewDelegateProxy.proxy(for: base)
        
        // swiftlint:disable force_cast
        let didReceiveAd = delegateProxy
            .methodInvoked(#selector(HZBannerAdDelegate.bannerDidReceive(_:)))
            .map { $0[0] as! HZBannerAd }
        
        let didFailToReceiveAd = delegateProxy
            .methodInvoked(#selector(HZBannerAdDelegate.bannerDidFail(toReceive:error:)))
            .flatMap { input -> Observable<HZBannerAd> in
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

public class RxHZBannerViewDelegateProxy: DelegateProxy<HZBannerAd, HZBannerAdDelegate>, DelegateProxyType, HZBannerAdDelegate {
    public static func registerKnownImplementations() {
        self.register { RxHZBannerViewDelegateProxy(bannerView: $0) }
    }
    
    internal init(bannerView: HZBannerAd) {
        super.init(parentObject: bannerView, delegateProxy: RxHZBannerViewDelegateProxy.self)
    }
    
    public static func currentDelegate(for object: HZBannerAd) -> HZBannerAdDelegate? {
        let bannerView = object
        return bannerView.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: HZBannerAdDelegate?, to object: HZBannerAd) {
        let bannerView = object
        bannerView.delegate = delegate as? RxHZBannerViewDelegateProxy
    }
}

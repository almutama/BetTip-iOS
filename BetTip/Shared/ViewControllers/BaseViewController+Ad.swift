//
//  BaseViewController+Ad.swift
//  BetTip
//
//  Created by Haydar Karkin on 16.06.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation

extension BaseViewController: HZAdsDelegate {
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController!) {
        print("productViewControllerDidFinish")
        self.dismiss(animated: true, completion: nil)
    }
    
    func didShowAd(withTag tag: String!) {
        // Sent when an interstitial ad has been displayed.
        print("didShowAdWithTag", tag)
    }
    
    func didFailToShowAd(withTag tag: String!, andError error: Error!) {
        // Sent when you call `showAd`, but there isn't an ad to be shown.
        // Includes an NSError object describing the reason why.
        print("didFailToShowAdWithTag", tag)
    }
    
    func didClickAd(withTag tag: String!) {
        // Sent when an interstitial ad has been clicked.
        print("didClickAdWithTag", tag)
    }
    
    func didHideAd(withTag tag: String!) {
        // Sent when an interstitial ad has been removed from view.
        print("didHideAdWithTag", tag)
    }
    
    func didReceiveAd(withTag tag: String!) {
        // Sent when an interstitial ad has been loaded and is ready to be displayed.
        print("didReceiveAdWithTag", tag)
    }
    
    func didFailToReceiveAd(withTag tag: String!) {
        // Sent when an interstitial ad has failed to load.
        print("didFailToReceiveAdWithTag")
    }
    
    func willStartAudio() {
        // The ad about to be shown will need audio. Mute any background music.
        print("willStartAudio")
    }
    
    func didFinishAudio() {
        // The ad being shown no longer needs audio.
        // Any background music can be resumed.
        print("didFinishAudio")
    }
}

//
//  HockeyApp.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import HockeySDK
import Keys

class HockeyApp {
    
    fileprivate let hockeyAppIdentificationKey = "HockeyAppIdentificationKey"
    
    var buildString: String {
        guard let bundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] else { return "build #" }
        
        return "build #\(bundleVersion)"
    }
    
    var isIdentificationPassed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hockeyAppIdentificationKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hockeyAppIdentificationKey)
        }
    }
    
    fileprivate func setupNoAuth() {
        return
    }
    
    fileprivate func setupEmailAuth() {
        //disable checking for new version for debug builds
        #if DEBUG
            BITHockeyManager.shared().isUpdateManagerDisabled = true
        #endif
        BITHockeyManager.shared().configure(withIdentifier: BetTipKeys().hockeyID)
        BITHockeyManager.shared().isStoreUpdateManagerEnabled = true
        BITHockeyManager.shared().storeUpdateManager.isCheckingForUpdateOnLaunch = true
        BITHockeyManager.shared().authenticator.identificationType = .hockeyAppUser
        BITHockeyManager.shared().authenticator.restrictApplicationUsage = true
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.identify { identified, _ in
            if identified {
                self.isIdentificationPassed = true
            }
        }
    }
    
    func setupAuth() {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            setupNoAuth()
        #else
            setupEmailAuth()
        #endif
    }
    
    func validateAuth() -> (((Bool, Error?) -> Swift.Void)!) -> Void {
        return BITHockeyManager.shared().authenticator.validate
    }
    
    func identify() -> (((Bool, Error?) -> Swift.Void)!) -> Void {
        return BITHockeyManager.shared().authenticator.identify
    }
}

//
//  AppDelegate.swift
//  BetTip
//
//  Created by Haydar Karkin on 23/10/2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import IQKeyboardManagerSwift
import UserNotifications
import Keys
import Swinject
import SwinjectStoryboard
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate let appAssembler = AppAssembly.sharedInstance
    fileprivate let logger = Log.createLogger()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        self.setupNotification(application: application)
        self.registerServices()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {

        #if DEBUG || ADHOC || INHOUSE
        if !HockeyAppManager().isIdentificationPassed {
            let identify = HockeyAppManager().identify()
            identify { identified, error in
                if !identified, let error = error {
                    self.logger.log(.debug, error.localizedDescription)
                }
            }
        }
        #endif
    }
    
    func registerServices() {
        // MARK: DB setup
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        Database.database().reference().keepSynced(true)
        
        // MARK: Adverts
        GADMobileAds.configure(withApplicationID: Constants.adMobID)
        //HeyzapAds.start(withPublisherID: BetTipKeys().heyzapID)

        // MARK: Services
        UIService.shared.registerForEvents()
        UserEventService.shared.registerForEvents()
        IQKeyboardManager.shared.enable = true
        
        // MARK: Reports
        #if DEBUG || ADHOC || INHOUSE
        HockeyAppManager().setupAuth()
        #endif
        AnalyticsManager.sharedManager.register(newService: FirebaseAnalytics())
        AnalyticsManager.sharedManager.register(newService: AnalyticsLogger())
        
        // MARK: Payment Transaction
        PurchaseService().completeTransactions()
    }
}

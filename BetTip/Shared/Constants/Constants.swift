//
//  Constants.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

struct Constants {
    //Auth
    static let emailKey = "email"
    static let passwordKey = "password"
    static let profileKey = "profile"
    static let onboardingDefaults  = "onboarding"
    static let authTypeKey = "authType"
    static let activeAuthProviderKey = "activeAuthProvider"
    static let credentialKey: String = "credential"
    
    //Profile
    static let firstNameString = "firstName"
    static let lastNameString = "lastName"
    static let phoneNumberString = "phoneNumber"
    static let emailString = "email"
    static let profileIdString = "profileID"
    
    //Firebase
    static let matches = "Matches"
    static let users = "Users"
    static let moderators = "Moderators"
    static let admins = "Admins"
    static let disabledUsers = "DisabledUsers"
    static let credits = "Credits"
    static let coupons = "Coupons"
    static let userCoupons = "UserCoupons"
    static let userCredits = "UserCredits"
    static let stats = "Stats"
    static let basketball = "\(stats)/Basketball"
    static let football = "\(stats)/Football"
    static let status = "status"
    static let type = "type"
    static let isSpecial = "isSpecial"
    static let advertisement = "Advertisement"
    static let footballType = 1
    static let basketballType = 2
    static let queryLimit: UInt = 50
    static let queryLimitForAll: UInt = 100
    static let bannerImg = "Banners/banner.png"
    
    //UI
    static let baseDesignScreenWidth: CGFloat = 375.0
    static let baseDesignScreenHeight: CGFloat = 667.0
    
    //ErrorEvent class
    static let errorEventName = "Error"                     // error name
    static let errorEventDebugInfoDatapoint = "DebugInfo"   // datapoint key for error's debug info
    static let exceptionEventName = "Exception"             // exception name
    static let exceptionTraceDatapointName = "trace"        // datapoint key
    static let exceptionDescriptionDatapointName = "description" // datapoint key
    
    //NotificationCenter
    static let betTipAdsRemoved = Notification.Name("BetTipAdsRemovedNotification")
}

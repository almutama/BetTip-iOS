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
    static let userCredits = "UserCredits"
    static let stats = "Stats"
    static let basketball = "\(stats)/Basketball"
    static let football = "\(stats)/Football"
    static let status = "status"
    static let type = "type"
    static let footballType = 1
    static let basketballType = 2
    static let queryLimit: UInt = 50
    
    //UI
    static let baseDesignScreenWidth: CGFloat = 375.0
    static let baseDesignScreenHeight: CGFloat = 667.0
}

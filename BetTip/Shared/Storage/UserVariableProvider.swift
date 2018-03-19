//
//  UserVariableProvider.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

protocol UserVariableProviderType {
    var deviceUUID: String { get }
}

class UserVariableProvider: UserVariableProviderType {
    fileprivate typealias `Self` = UserVariableProvider
    
    static var sharedInstance = UserVariableProvider()
    fileprivate var defaults = UserDefaults.standard

    var deviceUUID: String {
        var id = defaults.string(forKey: "deviceUUID")
        if id == nil {
            id = UUID().uuidString
            defaults.setValue(id, forKey: "deviceUUID")
        }
        return id!
    }
}

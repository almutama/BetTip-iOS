//
//  BGDidLoginEvent.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

class BGDidLoginEvent: BGEventBusEvent {
    typealias EventResult = BGDidLoginEvent
    
    var user: UserModel
    var password: String?
    var facebookToken: String?
    
    init(user: UserModel, password: String? = nil, facebookToken: String? = nil) {
        self.user = user
        self.password = password
        self.facebookToken = facebookToken
    }
    
}

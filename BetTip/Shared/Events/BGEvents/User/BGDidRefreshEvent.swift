//
//  BGDidRefreshEvent.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

class BGDidRefreshEvent: BGEventBusEvent {
    typealias EventResult = BGDidRefreshEvent
    
    var user: UserModel
    init(user: UserModel) {
        self.user = user
    }
    
}

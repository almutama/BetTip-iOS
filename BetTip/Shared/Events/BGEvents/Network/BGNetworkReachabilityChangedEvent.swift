//
//  BGNetworkReachabilityChangedEvent.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

class BGNetworkReachabilityChangedEvent: BGEventBusEvent {
    
    typealias EventResult = BGNetworkReachabilityChangedEvent
    
    var reachable: Bool
    
    init(reachable: Bool) {
        self.reachable = reachable
        super.init()
    }
}

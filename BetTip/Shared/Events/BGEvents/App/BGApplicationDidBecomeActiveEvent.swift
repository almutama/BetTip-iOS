//
//  BGApplicationDidBecomeActiveEvent.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

class BGApplicationDidBecomeActiveEvent: BGEventBusEvent {
    
    typealias EventResult = BGApplicationDidBecomeActiveEvent
    
    var fromBackground: Bool = false
    var backgroundTime: TimeInterval?
    
    init(fromBackground: Bool) {
        self.fromBackground = fromBackground
    }
    
    init(fromBackground: Bool, backgroundTime: TimeInterval) {
        self.fromBackground = fromBackground
        self.backgroundTime = backgroundTime
    }
    
}

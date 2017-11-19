//
//  BGEventBusEvent.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

open class BGEventBusEvent: PubSubEvent {
    
    public init() {}
    
    public class func eventName() -> String {
        return String(describing: self)
    }
    
    public func send() {
        BGEventBus.sharedInstance.send(event: self)
    }
}

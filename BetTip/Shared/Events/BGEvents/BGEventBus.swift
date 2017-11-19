//
//  BGEventBus.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

class BGEventBus: EventBus {
    
    static let sharedInstance = BGEventBus()
    
    init() {
        super.init(queue: OperationQueue())
    }
    
}

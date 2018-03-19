//
//  UIEventBus.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

class UIEventBus: EventBus {
    
    static let sharedInstance = UIEventBus()
    
    init() {
        super.init(queue: OperationQueue.main)
    }
    
}

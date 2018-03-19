//
//  UIShowLoginScreenEvent.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

class UIShowLoginScreenEvent: UIEventBusEvent {
    typealias EventResult = UIShowLoginScreenEvent
    
    let transition: UIViewAnimationOptions
    
    init(_ transition: UIViewAnimationOptions) {
        self.transition = transition
    }
}

//
//  UIShowMainScreenEvent.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

class UIShowMainScreenEvent: UIEventBusEvent {
    typealias EventResult = UIShowMainScreenEvent
    
    let transition: UIView.AnimationOptions
    
    init(_ transition: UIView.AnimationOptions) {
        self.transition = transition
    }
}

//
//  CouponAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 16.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class CouponAssembly: Assembly {
    
    func assemble(container: Container) {
        
        Container.loggingFunction = nil
        
        // Services
        container.register(CouponServiceType.self) { r in
            CouponService(userService: r.resolve(UserServiceType.self)!)
        }
        
        // ViewModels
        container.register(CouponsVMType.self) { r in
            CouponsVM(couponService: r.resolve(CouponServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(CouponsVC.self) {r, c in
            c.viewModel = r.resolve(CouponsVMType.self)
        }
    }
}

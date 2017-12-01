//
//  CouponAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class CouponAssembly: Assembly {

    func assemble(container: Container) {
        // Services
        container.register(CouponServiceType.self) { _ in
            CouponService()
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

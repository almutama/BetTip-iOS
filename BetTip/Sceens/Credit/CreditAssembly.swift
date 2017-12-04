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

class CreditAssembly: Assembly {

    func assemble(container: Container) {
        // Services
        container.register(CreditServiceType.self) { _ in
            CreditService()
        }
        
        // ViewModels
        container.register(CreditsVMType.self) { r in
            CreditsVM(couponService: r.resolve(CreditServiceType.self)!)
        }
        container.register(BuyCreditVMType.self) { r in
            BuyCreditVM(couponService: r.resolve(CreditServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(CreditsVC.self) {r, c in
            c.viewModel = r.resolve(CreditsVMType.self)
        }
        container.storyboardInitCompleted(BuyCreditVC.self) {r, c in
            c.viewModel = r.resolve(BuyCreditVMType.self)
        }
    }
}

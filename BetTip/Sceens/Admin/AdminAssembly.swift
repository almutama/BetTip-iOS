//
//  AdminAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class AdminAssembly: Assembly {
    
    func assemble(container: Container) {
        
        Container.loggingFunction = nil
        
        // Services
        container.register(AdminServiceType.self) { r in
            AdminService(userService: r.resolve(UserServiceType.self)!,
                         creditService: r.resolve(CreditServiceType.self)!,
                         couponService: r.resolve(CouponServiceType.self)!,
                         matchService: r.resolve(MatchServiceType.self)!)
        }
        
        // ViewModels
        container.register(AdminVMType.self) { r in
            AdminVM(adminService: r.resolve(AdminServiceType.self)!)
        }
        container.register(ControlCouponsVMType.self) { r in
            ControlCouponsVM(adminService: r.resolve(AdminServiceType.self)!)
        }
        container.register(ControlCreditsVMType.self) { r in
            ControlCreditsVM(adminService: r.resolve(AdminServiceType.self)!)
        }
        container.register(ControlUsersVMType.self) { r in
            ControlUsersVM(adminService: r.resolve(AdminServiceType.self)!)
        }
        container.register(AddCouponVMType.self) { r in
            AddCouponVM(adminService: r.resolve(AdminServiceType.self)!)
        }
        container.register(AddMatchVMType.self) { r in
            AddMatchVM(adminService: r.resolve(AdminServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(AdminVC.self) {r, c in
            c.viewModel = r.resolve(AdminVMType.self)
        }
        container.storyboardInitCompleted(ControlCouponsVC.self) {r, c in
            c.viewModel = r.resolve(ControlCouponsVMType.self)
        }
        container.storyboardInitCompleted(ControlCreditsVC.self) {r, c in
            c.viewModel = r.resolve(ControlCreditsVMType.self)
        }
        container.storyboardInitCompleted(ControlUsersVC.self) {r, c in
            c.viewModel = r.resolve(ControlUsersVMType.self)
        }
        container.storyboardInitCompleted(AddCouponVC.self) {r, c in
            c.viewModel = r.resolve(AddCouponVMType.self)
        }
        container.storyboardInitCompleted(AddMatchVC.self) {r, c in
            c.viewModel = r.resolve(AddMatchVMType.self)
        }
    }
}

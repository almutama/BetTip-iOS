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
        // Services
        container.register(AdminServiceType.self) { _ in
            AdminService()
        }
        
        // ViewModels
        container.register(AdminVM.self) { r in
            AdminVM(adminService: r.resolve(AdminServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(AdminVC.self) {r, c in
            c.viewModel = r.resolve(AdminVMType.self)
        }
    }
}

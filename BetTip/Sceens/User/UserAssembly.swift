//
//  UserAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class UserAssembly: Assembly {
    
    func assemble(container: Container) {
        
        Container.loggingFunction = nil
        
        // Services
        container.register(UserServiceType.self) { _ in
            UserService()
        }
        container.register(AuthStoreType.self) { _ in
            AuthStore()
        }
        container.register(AuthProviderType.self) { r in
            AuthProvider(authStore: r.resolve(AuthStoreType.self)!,
                         loginService: r.resolve(LoginServiceType.self)!)
        }
        container.register(AuthManagerType.self) { r in
            AuthManager(authStore: r.resolve(AuthStoreType.self)!,
                        authProvider: r.resolve(AuthProviderType.self)!)
        }
        
        // ViewModels
        container.register(UserVMType.self) { r in
            UserVM(authStore: r.resolve(AuthStoreType.self)!,
                   authManager: r.resolve(AuthManagerType.self)!,
                   userService: r.resolve(UserServiceType.self)!)
        }
        
        container.register(MyCouponsVMType.self) { r in
            MyCouponsVM(userService: r.resolve(UserServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(UserVC.self) {r, c in
            c.viewModel = r.resolve(UserVMType.self)
        }
        
        container.storyboardInitCompleted(MyCouponsVC.self) {r, c in
            c.viewModel = r.resolve(MyCouponsVMType.self)
        }
        
        container.storyboardInitCompleted(MyCouponDetailVC.self) {r, c in
            c.viewModel = r.resolve(MyCouponDetailVM.self)
        }
    }
}

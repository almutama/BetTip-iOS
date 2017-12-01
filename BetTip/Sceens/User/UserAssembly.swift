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
        container.register( UserVM.self) { r in
            UserVM(authStore: r.resolve(AuthStoreType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(UserVC.self) {r, c in
            c.viewModel = r.resolve(UserVM.self)
        }
    }
}

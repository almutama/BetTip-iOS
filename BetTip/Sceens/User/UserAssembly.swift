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
    var assembler: Assembler!
    
    func assemble(container: Container) {
        
        assembler = Assembler([UserViewModelAssembly(), UserServiceAssembly()])
        Container.loggingFunction = nil
        
        container.storyboardInitCompleted(UserVC.self) {_, c in
            let resolver = self.assembler.resolver
            c.viewModel = resolver.resolve(UserVM.self)
        }
    }
    
}

class UserViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register( UserVM.self) { r in
            UserVM(authStore: r.resolve(AuthStoreType.self)!)
            }.inObjectScope(.container)
    }
}

class UserServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserServiceType.self) { _ in
            UserService()
            }.inObjectScope(.container)
        
        container.register(AuthStoreType.self) { _ in
            AuthStore()
            }.inObjectScope(.container)
        
        container.register(AuthProviderType.self) { r in
            AuthProvider(authStore: r.resolve(AuthStoreType.self)!,
                         loginService: r.resolve(LoginServiceType.self)!)
            }.inObjectScope(.container)
        
        container.register(AuthManagerType.self) { r in
            AuthManager(authStore: r.resolve(AuthStoreType.self)!,
                        authProvider: r.resolve(AuthProviderType.self)!)
            }.inObjectScope(.container)
    }
}

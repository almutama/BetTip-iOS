//
//  LoginAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 23.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class LoginAssembly: Assembly {
    var assembler: Assembler!
    
    func assemble(container: Container) {
        
        assembler = Assembler([LoginViewModelAssembly(), LoginServiceAssembly()])
        Container.loggingFunction = nil
        
        container.storyboardInitCompleted(LoginVC.self) { r, c in
            c.viewModel = r.resolve(LoginVM.self)
        }
        
        container.storyboardInitCompleted(RegisterVC.self) { r, c in
            c.viewModel = r.resolve(RegisterVM.self)
        }
        
        container.storyboardInitCompleted(ForgotPasswordVC.self) { r, c in
            c.viewModel = r.resolve(ForgotPasswordVM.self)
        }
    }
    
}

class LoginViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LoginVM.self) { r in
            LoginVM(authProvider: r.resolve(AuthProviderType.self)!)
            }.inObjectScope(.container)
        
        container.register(RegisterVM.self) { r in
            RegisterVM(authProvider: r.resolve(AuthProviderType.self)!)
            }.inObjectScope(.container)
        
        container.register(ForgotPasswordVM.self) { r in
            ForgotPasswordVM(authProvider: r.resolve(AuthProviderType.self)!)
            }.inObjectScope(.container)
    }
    
}

class LoginServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LoginServiceType.self) { r in
            LoginService(userService: r.resolve(UserServiceType.self)!)
            }.inObjectScope(.container)
    }
}

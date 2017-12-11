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

    func assemble(container: Container) {
        
        Container.loggingFunction = nil
        
        // Services
        container.register(LoginServiceType.self) { r in
            LoginService(userService: r.resolve(UserServiceType.self)!)
        }
        
        // ViewModels
        container.register(LoginVMType.self) { r in
            LoginVM(authProvider: r.resolve(AuthProviderType.self)!)
        }
        container.register(RegisterVMType.self) { r in
            RegisterVM(authProvider: r.resolve(AuthProviderType.self)!,
                       userService: r.resolve(UserServiceType.self)!)
        }
        container.register(ForgotPasswordVMType.self) { r in
            ForgotPasswordVM(authProvider: r.resolve(AuthProviderType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(LoginVC.self) { r, c in
            c.viewModel = r.resolve(LoginVMType.self)
        }
        container.storyboardInitCompleted(RegisterVC.self) { r, c in
            c.viewModel = r.resolve(RegisterVMType.self)
        }
        container.storyboardInitCompleted(ForgotPasswordVC.self) { r, c in
            c.viewModel = r.resolve(ForgotPasswordVMType.self)
        }
    }
}

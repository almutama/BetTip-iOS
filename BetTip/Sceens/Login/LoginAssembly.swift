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
    }
    
}

class LoginViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LoginVM.self) { r in
            LoginVM(authProvider: r.resolve(AuthProvider.self)!)
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

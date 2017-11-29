//
//  BasketballAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class BasketballAssembly: Assembly {
    var assembler: Assembler!
    
    func assemble(container: Container) {
        
        assembler = Assembler([SplashViewModelAssembly()])
        Container.loggingFunction = nil
        
        container.storyboardInitCompleted(BasketballVC.self) {_, c in
            let resolver = self.assembler.resolver
            c.viewModel = resolver.resolve(BasketballVM.self)
        }
    }
}

class BasketballViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register( BasketballVM.self) { r in
            BasketballVM(authManager: r.resolve(AuthManagerType.self)!)
            }.inObjectScope(.container)
    }
}

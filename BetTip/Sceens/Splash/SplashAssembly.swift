//
//  SplashAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class SplashAssembly: Assembly {
    var assembler: Assembler!
    
    func assemble(container: Container) {
        
        assembler = Assembler([LoginAssembly(), UserAssembly(), SplashViewModelAssembly()])
        Container.loggingFunction = nil
        
        container.storyboardInitCompleted(SplashVC.self) {r, c in
            c.viewModel = r.resolve(SplashVM.self)
        }
    }
}

class SplashViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register( SplashVM.self) { r in
            SplashVM(authManager: r.resolve(AuthManagerType.self)!)
            }.inObjectScope(.container)
    }
}

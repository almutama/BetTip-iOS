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
        
        // ViewModels
        container.register(SplashVMType.self) { r in
            SplashVM(authManager: r.resolve(AuthManagerType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(SplashVC.self) {r, c in
            c.viewModel = r.resolve(SplashVMType.self)
        }
    }
}

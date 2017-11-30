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
        
        assembler = Assembler([BasketballViewModelAssembly(), BasketballServiceAssembly()])
        Container.loggingFunction = nil
        
        container.storyboardInitCompleted(BasketballVC.self) {r, c in
            c.viewModel = r.resolve(BasketballVM.self)
        }
    }
}

class BasketballViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register( BasketballVM.self) { r in
            BasketballVM(basketballService: r.resolve(BasketballServiceType.self)!)
            }.inObjectScope(.container)
    }
}

class BasketballServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(BasketballServiceType.self) { _ in
            BasketballService()
            }.inObjectScope(.container)
    }
}

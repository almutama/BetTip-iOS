//
//  FootballAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class FootballAssembly: Assembly {
    var assembler: Assembler!
    
    func assemble(container: Container) {
        
        assembler = Assembler([FootballViewModelAssembly(), FootballServiceAssembly()])
        Container.loggingFunction = nil
        
        container.storyboardInitCompleted(FootballVC.self) {r, c in
            c.viewModel = r.resolve(FootballVM.self)
        }
    }
}

class FootballViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register( FootballVM.self) { r in
            FootballVM(footballService: r.resolve(FootballServiceType.self)!)
            }.inObjectScope(.container)
    }
}

class FootballServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(FootballServiceType.self) { _ in
            FootballService()
            }.inObjectScope(.container)
    }
}

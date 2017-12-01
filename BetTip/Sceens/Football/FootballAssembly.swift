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

    func assemble(container: Container) {
        // Services
        container.register(FootballServiceType.self) { _ in
            FootballService()
        }
        
        // ViewModels
        container.register( FootballVM.self) { r in
            FootballVM(footballService: r.resolve(FootballServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(FootballVC.self) {r, c in
            c.viewModel = r.resolve(FootballVMType.self)
        }
    }
}

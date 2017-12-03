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

    func assemble(container: Container) {
        // Services
        container.register(BasketballServiceType.self) { _ in
            BasketballService()
        }
        
        // ViewModels
        container.register(BasketballVMType.self) { r in
            BasketballVM(basketballService: r.resolve(BasketballServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(BasketballVC.self) {r, c in
            c.viewModel = r.resolve(BasketballVMType.self)
        }
    }
}

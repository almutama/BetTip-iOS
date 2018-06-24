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
        
        Container.loggingFunction = nil
        
        // ViewModels
        container.register(BasketballVMType.self) { r in
            BasketballVM(matchService: r.resolve(MatchServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(BasketballVC.self) {r, c in
            c.viewModel = r.resolve(BasketballVMType.self)
            c.bannerView = r.resolve(AdBannerViewType.self)
        }
    }
}

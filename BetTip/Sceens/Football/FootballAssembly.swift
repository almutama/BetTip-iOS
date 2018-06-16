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
        
        Container.loggingFunction = nil
        
        // ViewModels
        container.register(FootballVMType.self) { r in
            FootballVM(matchService: r.resolve(MatchServiceType.self)!)
        }
        
        // ViewControllers
        container.storyboardInitCompleted(FootballVC.self) {r, c in
            c.viewModel = r.resolve(FootballVMType.self)
            c.bannerView = r.resolve(AdBannerViewType.self)
        }
    }
}

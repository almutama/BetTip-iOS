//
//  MainAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 24.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MainAssembly: Assembly {
    
    func assemble(container: Container) {
        
        Container.loggingFunction = nil
        
        // Services
        container.register(PurchaseServiceType.self) { _ in
            PurchaseService()
        }
        container.register(AdServiceType.self) { _ in
            AdService()
        }
        
        // ViewModels
        container.register(AdBannerVMType.self) { r in
            AdBannerVM(adService: r.resolve(AdServiceType.self)!)
        }
        
        // Views
        container.register(AdBannerViewType.self) {r in
            AdBannerView(viewModel: r.resolve(AdBannerVMType.self)!)
        }
    }
}

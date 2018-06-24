//
//  MatchAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 8.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MatchAssembly: Assembly {
    
    func assemble(container: Container) {
        
        Container.loggingFunction = nil
        
        // Services
        container.register(MatchServiceType.self) { _ in
            MatchService()
        }
    }
}

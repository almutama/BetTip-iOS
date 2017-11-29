//
//  CouponAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class CouponAssembly: Assembly {
    var assembler: Assembler!
    
    func assemble(container: Container) {
        
        assembler = Assembler([CouponViewModelAssembly(), CouponServiceAssembly()])
        Container.loggingFunction = nil
        
        container.storyboardInitCompleted(CouponsVC.self) {_, c in
            let resolver = self.assembler.resolver
            c.viewModel = resolver.resolve(CouponsVM.self)
        }
    }
}

class CouponViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register( CouponsVM.self) { r in
            CouponsVM(couponService: r.resolve(CouponServiceType.self)!)
            }.inObjectScope(.container)
    }
}

class CouponServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CouponServiceType.self) { _ in
            CouponService()
            }.inObjectScope(.container)
    }
}

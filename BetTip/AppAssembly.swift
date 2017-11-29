//
//  AppAssembly.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class AppAssembly: NSObject {
    
    class var sharedInstance: AppAssembly {
        struct Static {
            static let instance = AppAssembly()
        }
        return Static.instance
    }
    
    fileprivate let assembler = Assembler([
        LoginAssembly(), UserAssembly(), SplashAssembly(), BasketballAssembly()
        ], container: SwinjectStoryboard.defaultContainer)
    
}

extension UIViewController {
    var assembler: AppAssembly { return AppAssembly.sharedInstance }
}

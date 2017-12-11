//
//  SwinjectStoryboard+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 1.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        performSetup()
    }
    
    class func performSetup() {
        Container.loggingFunction = nil
        defaultContainer.register(UserServiceType.self) { _ in
            UserService()
            }.inObjectScope(.container)
        
        defaultContainer.register(LoginServiceType.self) { r in
            LoginService(userService: r.resolve(UserServiceType.self)!)
            }.inObjectScope(.container)
        
        defaultContainer.register(AuthStoreType.self) { _ in
            AuthStore()
            }.inObjectScope(.container)
        
        defaultContainer.register(AuthProviderType.self) { r in
            AuthProvider(authStore: r.resolve(AuthStoreType.self)!,
                         loginService: r.resolve(LoginServiceType.self)!)
            }.inObjectScope(.container)
        
        defaultContainer.register(AuthManagerType.self) { r in
            AuthManager(authStore: r.resolve(AuthStoreType.self)!,
                        authProvider: r.resolve(AuthProviderType.self)!)
            }.inObjectScope(.container)
        
        defaultContainer.register(BasketballServiceType.self) { _ in
            BasketballService()
            }.inObjectScope(.container)
        
        defaultContainer.register(CreditServiceType.self) { r in
            CreditService(userService: r.resolve(UserServiceType.self)!)
            }.inObjectScope(.container)
        
        defaultContainer.register(FootballServiceType.self) { _ in
            FootballService()
            }.inObjectScope(.container)
        
        defaultContainer.register(BasketballVM.self) { r in
            BasketballVM(basketballService: r.resolve(BasketballServiceType.self)!)
            }
        
        defaultContainer.register(CreditsVM.self) { r in
            CreditsVM(creditService: r.resolve(CreditServiceType.self)!)
            }
        
        defaultContainer.register(FootballVM.self) { r in
            FootballVM(footballService: r.resolve(FootballServiceType.self)!)
            }
        
        defaultContainer.register(LoginVM.self) { r in
            LoginVM(authProvider: r.resolve(AuthProviderType.self)!)
            }
        
        defaultContainer.register(RegisterVM.self) { r in
            RegisterVM(authProvider: r.resolve(AuthProviderType.self)!,
                       userService: r.resolve(UserServiceType.self)!)
            }
        
        defaultContainer.register(ForgotPasswordVM.self) { r in
            ForgotPasswordVM(authProvider: r.resolve(AuthProviderType.self)!)
            }
        
        defaultContainer.register(SplashVM.self) { r in
            SplashVM(authManager: r.resolve(AuthManagerType.self)!)
            }
        
        defaultContainer.register(UserVM.self) { r in
            UserVM(authStore: r.resolve(AuthStoreType.self)!)
            }
        
        defaultContainer.storyboardInitCompleted(BasketballVC.self) {r, c in
            c.viewModel = r.resolve(BasketballVMType.self)
        }
        
        defaultContainer.storyboardInitCompleted(CreditsVC.self) {r, c in
            c.viewModel = r.resolve(CreditsVM.self)
        }
        
        defaultContainer.storyboardInitCompleted(FootballVC.self) {r, c in
            c.viewModel = r.resolve(FootballVM.self)
        }
        
        defaultContainer.storyboardInitCompleted(LoginVC.self) { r, c in
            c.viewModel = r.resolve(LoginVM.self)
        }
        
        defaultContainer.storyboardInitCompleted(RegisterVC.self) { r, c in
            c.viewModel = r.resolve(RegisterVM.self)
        }
        
        defaultContainer.storyboardInitCompleted(SplashVC.self) {r, c in
            c.viewModel = r.resolve(SplashVM.self)
        }
        
        defaultContainer.storyboardInitCompleted(ForgotPasswordVC.self) { r, c in
            c.viewModel = r.resolve(ForgotPasswordVM.self)
        }
        
        defaultContainer.storyboardInitCompleted(UserVC.self) {r, c in
            c.viewModel = r.resolve(UserVM.self)
        }
    }
    
    class func resolve<T>(_ serviceType: T.Type) -> T {
        return defaultContainer.resolve(serviceType)!
    }
}

private func getBundleFile(_ filename: String, fileType: String) -> Data? {
    guard let path = Bundle.main.path(forResource: filename, ofType: fileType) else {
        return nil
    }
    return (try! Data(contentsOf: URL(fileURLWithPath: path)))
}

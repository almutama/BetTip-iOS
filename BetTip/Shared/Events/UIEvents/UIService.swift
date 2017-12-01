//
//  UIService.swift
//  BetTip
//
//  Created by Haydar Karkin on 28.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import Firebase

private let logger = Log.createLogger()

class UIService: PubSubSubscriberProtocol, EventBusObservable {
    
    static let shared = UIService()
    internal var eventBusObserver = EventBusObserver()
    
    private var rootWindow: UIWindow? {
        return UIApplication.shared.delegate?.window!
    }
    
    func registerForEvents() {
        self.handleBGEvent {[weak self] (event: BGDidLoginEvent) in
            DispatchQueue.main.async {
                logger.log(.debug, String(describing: event))
                self?.showMainScreen()
            }
        }
        
        self.handleBGEvent {(event: BGDidLogoutEvent) in
            logger.log(.debug, String(describing: event))
            UIShowLoginScreenEvent(.transitionCrossDissolve).send()
        }
        
        self.handleUIEvent {[weak self] (event: UIShowMainScreenEvent) in
            logger.log(.debug, String(describing: event))
            self?.showMainScreen()
        }
        
        self.handleUIEvent {[weak self] (event: UIShowLoginScreenEvent) in
            logger.log(.debug, String(describing: event))
            self?.showLoginScreen(event.transition)
        }
    }
    
    private func showMainScreen() {
        
        if let rootWindow = self.rootWindow {
            let vc = StoryboardScene.Main.initialScene.instantiate()
            rootWindow.rootViewController = vc
            UIView.transition(with: rootWindow, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        } else {
            logger.log(.error, "Main screen can't be initialized")
        }
    }
    
    private func showLoginScreen(_ transition: UIViewAnimationOptions) {
        if let rootWindow = self.rootWindow {
            let vc = StoryboardScene.Login.initialScene.instantiate()
            rootWindow.rootViewController = vc
            UIView.transition(with: rootWindow, duration: 0.5, options: transition, animations: nil, completion: nil)
        } else {
            logger.log(.error, "Login screen can't be initialized")
        }
    }
}

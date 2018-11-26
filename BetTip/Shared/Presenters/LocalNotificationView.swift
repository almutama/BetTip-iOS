//
//  MessageView.swift
//  BetTip
//
//  Created by Haydar Karkin on 27.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import SwiftMessages

class LocalNotificationView: SwiftMessages {
    
    open class var shared: LocalNotificationView {
        return LocalNotificationView()
    }
    
    open func showMessage(_ title: String?, body: String?, theme: Theme, level: UIWindow.Level, layout: MessageView.Layout) {
        DispatchQueue.main.async { () -> Void in
            let messageTitle = title ?? ""
            let messageBody = body ?? ""
            
            var message: MessageView = try! SwiftMessages.viewFromNib()
            switch layout {
            case .cardView, .messageView, .statusLine, .tabView, .centeredView:
                message = MessageView.viewFromNib(layout: layout)
            }
            
            message.configureTheme(theme)
            message.configureDropShadow()
            
            message.configureContent(title: messageTitle, body: messageBody)
            message.button?.isHidden = true
            var messageConfig = SwiftMessages.defaultConfig
            messageConfig.presentationContext = .window(windowLevel: level)
            messageConfig.duration = .seconds(seconds: 3)
            SwiftMessages.show(config: messageConfig, view: message)
        }
    }
    
    open func showSuccess(_ title: String?, body: String?) {
        DispatchQueue.main.async { () -> Void in
            self.showMessage(title, body: body, theme: .success, level: UIWindow.Level.statusBar, layout: .cardView)
        }
    }
    
    open func showError(_ title: String?, body: String?) {
        DispatchQueue.main.async { () -> Void in
            self.showMessage(title, body: body, theme: .error, level: UIWindow.Level.statusBar, layout: .cardView)
        }
    }
    
    open func showWarning(_ title: String?, body: String?) {
        DispatchQueue.main.async { () -> Void in
            self.showMessage(title, body: body, theme: .warning, level: UIWindow.Level.statusBar, layout: .cardView)
        }
    }
}

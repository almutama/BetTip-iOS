//
//  UIViewController+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 17.12.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public protocol AlertActionType {
    var title: String { get }
    var style: UIAlertActionStyle { get }
    var isEnabled: Bool { get }
}

extension AlertActionType {
    public var style: UIAlertActionStyle {
        return .default
    }
    public var isEnabled: Bool {
        return true
    }
}

extension Reactive where Base: UIAlertController {
    
    public typealias TextFieldConfiguration = ((UITextField) -> Void)
    
    public func presented<AlertAction: AlertActionType>(
        by vc: UIViewController,
        actions: [AlertAction],
        textFields: [TextFieldConfiguration?],
        animated: Bool = true,
        completion: (() -> Void)? = nil)
        -> ControlEvent<(action: AlertAction, texts: [String?]?)> {
            let source = Maybe<(action: AlertAction, texts: [String?]?)>
                .create { [weak vc] maybe in
                    guard let vc = vc else {
                        maybe(.completed)
                        return Disposables.create()
                    }
                    
                    let alertController = self.base
                    
                    actions
                        .map { action in
                            let alertAction = UIAlertAction(title: action.title, style: action.style) { [unowned alertController] _ in
                                maybe(.success((action, alertController.textFields?.map { $0.text })))
                            }
                            alertAction.isEnabled = action.isEnabled
                            return alertAction
                        }
                        .forEach(alertController.addAction)
                    
                    textFields.forEach(alertController.addTextField)
                    
                    DispatchQueue.main.async {
                        vc.present(alertController, animated: animated, completion: completion)
                    }
                    
                    return Disposables.create { [weak alertController] in
                        alertController?.dismiss(animated: true)
                    }
            }
            return ControlEvent(events: source.asObservable())
    }
    
    public func presented<AlertAction: AlertActionType>(
        by vc: UIViewController,
        actions: [AlertAction],
        animated: Bool = true,
        completion: (() -> Void)? = nil)
        -> ControlEvent<AlertAction> {
            let source = presented(by: vc, actions: actions, textFields: [], animated: animated, completion: completion)
                .map { $0.action }
            return ControlEvent(events: source)
    }
    
    public static func presented<AlertAction: AlertActionType>(
        by vc: UIViewController,
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertControllerStyle = .alert,
        actions: [AlertAction],
        textFields: [TextFieldConfiguration?],
        animated: Bool = true,
        completion: (() -> Void)? = nil)
        -> ControlEvent<(action: AlertAction, texts: [String?]?)> {
            return UIAlertController(title: title, message: message, preferredStyle: preferredStyle).rx
                .presented(by: vc, actions: actions, textFields: textFields, animated: animated, completion: completion)
    }
    
    public static func presented<AlertAction: AlertActionType>(
        by vc: UIViewController,
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertControllerStyle = .alert,
        actions: [AlertAction],
        animated: Bool = true,
        completion: (() -> Void)? = nil)
        -> ControlEvent<AlertAction> {
            return UIAlertController(title: title, message: message, preferredStyle: preferredStyle).rx
                .presented(by: vc, actions: actions, animated: animated, completion: completion)
    }
}

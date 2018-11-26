//
//  ThemeManager.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

protocol ThemeType {
    // fonts
    var header1Bold: Style { get }
    var header2Bold: Style { get }
    var header3Bold: Style { get }
    var header4Bold: Style { get }
    var header4Book: Style { get }
    var body1Bold: Style { get }
    var body1Book: Style { get }
    var body2Bold: Style { get }
    var body2Book: Style { get }
    var body3Bold: Style { get }
    var body3Book: Style { get }
    var notification1Bold: Style { get }
    var button1Bold: Style { get }
    var button2Bold: Style { get }
    var emoji: Style { get }
    
    // colors
    var main: UIColor { get }
    var secondary: UIColor { get }
    var complementary: UIColor { get }
    var generalText: UIColor { get }
    var secondaryText: UIColor { get }
    var complementaryText: UIColor { get }
    var highlight: UIColor { get }
    var defaultAction: UIColor { get }
    var secondaryAction: UIColor { get }
    var complementaryAction: UIColor { get }
    var shadow: UIColor { get }
    
    // sizes
    var extraLargeRowHeight: CGFloat { get }
    var largeRowHeight: CGFloat { get }
    var mediumRowHeight: CGFloat { get }
    var smallRowHeight: CGFloat { get }
    var actionButtonHeight: CGFloat { get }
    
    // system items
    var statusBarStyle: UIStatusBarStyle { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
}

protocol Theming {
    var theme: ThemeType { get }
    func apply()
}

final class ThemeManager {
    
    static let shared = ThemeManager()
    var currentTheme: ThemeType {
        didSet {
            apply()
        }
    }
    
    private init() {
        currentTheme = UIScreen.main.isCompactPhone ? DefaultCompactTheme() : DefaultTheme()
    }
    
    func apply() {
        setStandardNavBarAppearance()
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.backgroundColor = currentTheme.main
        }
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: currentTheme.body2Bold.font], for: .normal)
        
        UIPageControl.appearance().pageIndicatorTintColor = currentTheme.complementaryText
        UIPageControl.appearance().currentPageIndicatorTintColor = currentTheme.secondaryText
        
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = currentTheme.statusBarStyle
        
        UITableView.appearance().backgroundColor = currentTheme.secondary
        UITableView.appearance().separatorColor = currentTheme.complementary
        UITableView.appearance().separatorInset = .zero
    }
    
    func setStandardNavBarAppearance() {
        UINavigationBar.appearance().backgroundColor = currentTheme.secondary
        UINavigationBar.appearance().setBackgroundImage(UIImage(color: currentTheme.secondary), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = currentTheme.defaultAction
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: currentTheme.generalText,
            NSAttributedString.Key.font: currentTheme.body2Bold.font
        ]
    }
}

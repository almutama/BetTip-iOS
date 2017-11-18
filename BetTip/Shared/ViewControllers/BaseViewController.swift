//
//  BaseViewController.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.makeTheme()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func makeTheme() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20),
             NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.navbarBackground
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor.mainBackground
        
        self.activityIndicator.isHidden = true
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func isUIViewControllerPresentedAsModal() -> Bool {
        if((self.presentingViewController) != nil) {
            return true
        }
        
        if(self.presentingViewController?.presentedViewController == self) {
            return true
        }
        
        if(self.navigationController?.presentingViewController?.presentedViewController == self.navigationController) {
            return true
        }
        
        return false
    }
}

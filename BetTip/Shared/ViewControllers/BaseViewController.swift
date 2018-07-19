//
//  BaseViewController.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import SafariServices

class BaseViewController: UIViewController {
    
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
            [NSAttributedStringKey.font: FontFamily.Lato.black.font(size: 18),
             NSAttributedStringKey.foregroundColor: UIColor.secondary]
        self.navigationController?.navigationBar.barTintColor = UIColor.main
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor.main
    }
    
    func isUIViewControllerPresentedAsModal() -> Bool {
        if (self.presentingViewController) != nil {
            return true
        }
        
        if self.presentingViewController?.presentedViewController == self {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        }
        
        return false
    }
    
    func showNotification(result: Bool, title: String? = nil, body: String? = nil) {
        if result {
            LocalNotificationView.shared.showSuccess(L10n.Common.great, body: L10n.Common.Process.success)
        } else {
            LocalNotificationView.shared.showError(L10n.Common.sorry, body: L10n.Common.Process.error)
        }
    }
    
    func openUrl(url: URL, entersReaderIfAvailable: Bool = true) {
        let vc = SFSafariViewController(url: url, entersReaderIfAvailable: entersReaderIfAvailable)
        self.present(vc, animated: true)
    }
}

//
//  UIScreen+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen {
    var scaleForBaseDesign: CGFloat {
        if self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact {
            return self.bounds.size.width / Constants.baseDesignScreenWidth
        }
        return 1.0
    }
    var isiPhoneXResolution: Bool {
        if self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact {
            return self.bounds.size.height >= 812.0
        }
        return false
    }
    var isCompactPhone: Bool {
        return self.bounds.size.width <= 320.0
    }
}

//
//  StyledButton.swift
//  BetTip
//
//  Created by Haydar Karkin on 30.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

class StyledButton: UIButton {
    
    var style: Style? {
        didSet {
            updateStyle()
        }
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        if let style = style {
            setAttributedTitle((title != nil ? title! : "").styled(with: style), for: state)
        } else {
            super.setTitle(title, for: state)
        }
    }
    
    fileprivate func updateStyle() {
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected] {
            if let title = title(for: state) {
                setTitle(title, for: state)
            }
        }
    }
    
}

//
//  StyledTextField.swift
//  BetTip
//
//  Created by Haydar Karkin on 30.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

class StyledTextField: UITextField {
    
    var style: Style? {
        didSet {
            updateStyle()
        }
    }
    
    var placeholderColor: UIColor = .lightGray {
        didSet {
            updateStyle()
        }
    }
    
    let padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 20)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    fileprivate func tintClearImage() {
        for view in subviews where view is UIButton {
            guard let button = view as? UIButton else {
                return
            }
            button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.setImage(button.image(for: .highlighted)?.withRenderingMode(.alwaysTemplate), for: .highlighted)
            button.tintColor = tintColor
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tintClearImage()
    }
    
    fileprivate func updateStyle() {
        if let style = style {
            font = style.font
            textColor = style.color
            tintColor = style.color
            attributedPlaceholder = placeholder?.styled(with: style.colored(placeholderColor))
        }
    }
}

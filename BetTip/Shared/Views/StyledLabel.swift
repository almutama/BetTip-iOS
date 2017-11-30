//
//  StyledLabel.swift
//  BetTip
//
//  Created by Haydar Karkin on 30.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

class StyledLabel: UILabel {
    
    var style: Style? {
        didSet {
            updateStyle()
        }
    }
    
    var typographyType: TypographyType = .default {
        didSet {
            updateStyle()
        }
    }
    
    override var text: String? {
        didSet {
            updateStyle()
        }
    }
    
    fileprivate func updateStyle() {
        guard self.text != nil else { return }
        if let style = style {
            attributedText = text?.styled(with: style, type: typographyType, scale: 0.75)
        }
    }
    
}

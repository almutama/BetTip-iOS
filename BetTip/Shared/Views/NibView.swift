//
//  NibView.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

class NibView: UIView {
    var nibView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
        initialize()
    }
    
    init() {
        let emptyFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        super.init(frame: emptyFrame)
        loadFromNib()
        initialize()
    }
    
    func loadFromNib() {
        guard let nibName = nibName,
            let nibView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as? UIView else { return }
        self.nibView = nibView
        if shouldUseFrameFromNib() {
            bounds = nibView.frame
        } else {
            nibView.frame = bounds
        }
        super.addSubview(nibView)
    }
    
    func initialize() {
        guard let nibView = nibView, let superview = nibView.superview else { return }
        
        // autopin to superview
        nibView.translatesAutoresizingMaskIntoConstraints = false
        nibView.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        nibView.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        nibView.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        nibView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        guard let nibView = nibView else { super.layoutSubviews(); return }
        nibView.frame = bounds
        nibView.backgroundColor = backgroundColor
        nibView.layoutSubviews()
    }
    
    override func addSubview(_ view: UIView) {
        if let nibView = nibView {
            nibView.addSubview(view)
        } else {
            super.addSubview(view)
        }
    }
    
    func shouldUseFrameFromNib() -> Bool { return false }
    
    var nibName: String? {
        let typeLongName = type(of: self).description()
        let tokens = typeLongName.split(maxSplits: 10, omittingEmptySubsequences: true, whereSeparator: {$0 == "."}).map { String($0) }
        return tokens.last!
    }
}

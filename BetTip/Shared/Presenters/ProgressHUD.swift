//
//  ProgressHUD.swift
//  BetTip
//
//  Created by Haydar Karkin on 27.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

public enum ProgressHUDAnimation {
    
    case fade
    case zoomIn
    case zoomOut
    
}

@objc public protocol ProgressHUDDelegate {
    func hudDidHidden(_ hud: ProgressHUD)
}

open class ProgressHUD: UIView {
    
    open var labelText: String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
            self.setNeedsLayout() // layout
            self.setNeedsDisplay() // drawRect
        }
    }
    
    open var labelFont: UIFont! {
        get {
            return self.label.font
        }
        set {
            self.label.font = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    open var labelColor: UIColor! {
        get {
            return self.label.textColor
        }
        set {
            self.label.textColor = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    open var detailsLabelText: String? {
        get {
            return self.detailsLabel.text
        }
        set {
            self.detailsLabel.text = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    open var detailsLabelFont: UIFont! {
        get {
            return self.detailsLabel.font
        }
        set {
            self.detailsLabel.font = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    open var detailsLabelColor: UIColor! {
        get {
            return self.detailsLabel.textColor
        }
        set {
            self.detailsLabel.textColor = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    open weak var delegate: ProgressHUDDelegate?
    
    /**
     * Only show indicator view.
     * Defaults to false.
     */
    open var showIndicatorOnly = false
    
    /**
     * The type of indicator view.
     */
    open var animationType = ProgressHUDAnimation.fade
    
    /**
     * The amount of space between the HUD edge and the HUD elements.
     * Defaults to 20.0
     */
    open var margin = 20.0
    
    /**
     * The corner radius for the HUD
     * Defaults to 10.0
     */
    open var cornerRadius = 10.0
    
    /**
     * The color of the HUD window.
     * Defaults to black.
     */
    open var color: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
    
    /**
     * Cover the HUD background view with a radial gradient.
     * Defaults to false.
     */
    open var dimBackground: Bool = false
    
    /**
     * Force the HUD dimensions to be equal if possible.
     * Defaults to false
     */
    open var square: Bool = false
    
    /**
     * Removes the HUD from its parent view when hidden.
     * Defaults to false.
     */
    open var removeFromSuperViewOnHide: Bool = false
    
    open static let SubjectType = "NVProgressHUD"
    
    fileprivate var indicatorView: NVActivityIndicatorView
    fileprivate var label: UILabel
    fileprivate var detailsLabel: UILabel
    fileprivate var size = CGSize.zero
    fileprivate var indicatorType: NVActivityIndicatorType = NVActivityIndicatorType.ballSpinFadeLoader
    fileprivate var completionHandler: (() -> Void)?
    
    fileprivate let kPadding: CGFloat = 10.0
    fileprivate let kLabelFontSize: CGFloat = 16.0
    fileprivate let kDetailsLabelFontSize: CGFloat = 12.0
    fileprivate let kIndicatorSize: CGSize = CGSize(width: 40, height: 40)
    
    // MARK: - Init
    
    /**
     Create a progress HUD with specified frame and type
     
     - parameter frame: view's frame
     - parameter type: indicator type, value of NVActivityIndicatorType enum.
     - parameter color:    indicator color.
     
     - returns: The progress HUD
     */
    init(frame: CGRect, type: NVActivityIndicatorType = NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor = UIColor.white) {
        indicatorView = NVActivityIndicatorView(frame: frame, type: type, color: color)
        label = UILabel(frame: frame)
        detailsLabel = UILabel(frame: frame)
        self.indicatorType = type
        super.init(frame: frame)
        
        indicatorView.frame = CGRect(x: 0, y: 0, width: kIndicatorSize.width, height: kIndicatorSize.height)
        
        self.alpha = 0.0
        self.backgroundColor = UIColor.clear
        self.addSubview(indicatorView)
        self.addSubview(label)
        self.addSubview(detailsLabel)
        
        setupLabels()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        indicatorView = NVActivityIndicatorView(frame: CGRect.zero)
        label = UILabel(frame: CGRect.zero)
        detailsLabel = UILabel(frame: CGRect.zero)
        super.init(coder: aDecoder)
    }
    
    // MARK: - UI setup
    
    fileprivate func setupLabels() {
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: kLabelFontSize)
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        
        detailsLabel.textColor = UIColor.white
        detailsLabel.font = UIFont.boldSystemFont(ofSize: kDetailsLabelFontSize)
        detailsLabel.backgroundColor = UIColor.clear
        detailsLabel.textAlignment = NSTextAlignment.center
        detailsLabel.numberOfLines = 0
    }
    
    // MARK: - Layout
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if let parent = self.superview {
            self.frame = parent.bounds
        }
        let bounds = self.bounds
        
        // HUD size
        let maxWidth = bounds.width - 4 * CGFloat(margin)
        var totalSize = CGSize.zero
        
        // Indicator size
        var indicatorSize = indicatorView.bounds.size
        indicatorSize.width = min(indicatorSize.width, maxWidth)
        totalSize.width = max(indicatorSize.width, totalSize.width)
        totalSize.height += indicatorSize.height
        
        // Label size
        var labelSize = CGSize.zero
        if let text = label.text, text.isEmpty == false {
            labelSize = (text as NSString).size(withAttributes: [NSAttributedStringKey.font: label.font])
            labelSize.width = min(labelSize.width, maxWidth)
            totalSize.width = max(labelSize.width, totalSize.width)
        }
        totalSize.height += labelSize.height
        if labelSize.height > 0 && indicatorSize.height > 0 {
            totalSize.height += kPadding
        }
        
        // DetailsLabel size
        let remainingHeight = bounds.size.height - totalSize.height - kPadding - 4 * CGFloat(margin)
        let maxSize = CGSize(width: maxWidth, height: remainingHeight)
        var detailsLabelSize = CGSize.zero
        if let text = detailsLabel.text, text.isEmpty == false {
            detailsLabelSize = (text as NSString).boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: detailsLabel.font], context: nil).size
        }
        totalSize.width = max(detailsLabelSize.width, totalSize.width)
        totalSize.height += detailsLabelSize.height
        if detailsLabelSize.height > 0 && (indicatorSize.height > 0 || labelSize.height > 0) {
            totalSize.height += kPadding
        }
        
        totalSize.width += CGFloat(margin) * 2
        totalSize.height += CGFloat(margin) * 2
        
        // Indicator Position
        var xPosition = round((self.frame).midX - indicatorSize.width / 2)
        var yPosition = round(self.frame.midY - totalSize.height / 2 + CGFloat(margin))
        indicatorView.frame = CGRect(x: xPosition, y: yPosition, width: indicatorSize.width, height: indicatorSize.height)
        yPosition += indicatorSize.height + kPadding
        
        // Label Position
        xPosition = round((self.frame).midX - labelSize.width / 2)
        label.frame = CGRect(x: xPosition, y: yPosition, width: labelSize.width, height: labelSize.height)
        yPosition += round(label.bounds.height) + kPadding
        
        // DetailsLabel Position
        xPosition = round((self.frame).midX - detailsLabelSize.width / 2)
        detailsLabel.frame = CGRect(x: xPosition, y: yPosition, width: detailsLabelSize.width, height: detailsLabelSize.height)
        
        if square {
            let maxLength = max(totalSize.width, totalSize.height)
            if maxLength <= maxWidth {
                totalSize.width = maxLength
            }
            if maxLength <= bounds.height - CGFloat(margin) * 2 {
                totalSize.height = maxLength
            }
        }
        
        size = totalSize
    }
    
    override open func draw(_ rect: CGRect) {
        // Drawing code
        if showIndicatorOnly {
            return
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        if dimBackground {
            
            let gradLocations = [CGFloat(0.0), CGFloat(1.0)]
            let gradColors = [CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.75)]
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let gradient = CGGradient(colorSpace: colorSpace, colorComponents: gradColors, locations: gradLocations, count: 2)
            
            let gradCenter = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            let gradRadius = min(self.bounds.width, self.bounds.height)
            
            // draw gradient background
            context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0, endCenter: gradCenter, endRadius: gradRadius, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        }
        
        let roundedRect = CGRect(x: self.frame.midX-size.width/2, y: self.frame.midY-size.height/2, width: size.width, height: size.height)
        let radius = CGFloat(cornerRadius)
        
        // draw hud
        context?.beginPath()
        
        context?.move(to: CGPoint(x: roundedRect.minX, y: roundedRect.minY))
        context?.addArc( tangent1End: CGPoint(x: roundedRect.maxX, y: roundedRect.minY ),
                         tangent2End: CGPoint(x: roundedRect.maxX, y: roundedRect.maxY), radius: radius)
        context?.addArc( tangent1End: CGPoint(x: roundedRect.maxX, y: roundedRect.maxY ),
                         tangent2End: CGPoint(x: roundedRect.minX, y: roundedRect.maxY), radius: radius)
        context?.addArc( tangent1End: CGPoint(x: roundedRect.minX, y: roundedRect.maxY ),
                         tangent2End: CGPoint(x: roundedRect.minX, y: roundedRect.minY), radius: radius)
        context?.addArc( tangent1End: CGPoint(x: roundedRect.minX, y: roundedRect.minY ),
                         tangent2End: CGPoint(x: roundedRect.maxX, y: roundedRect.minY), radius: radius)
        
        context?.closePath()
        
        context?.setFillColor(color.cgColor)
        
        context?.fillPath()
        
    }
    
    // MARK: - show & hide
    
    open func show(_ animated: Bool) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        if animated {
            if animationType == ProgressHUDAnimation.zoomIn {
                self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            } else if animationType == ProgressHUDAnimation.zoomOut {
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            
            UIView .animate(withDuration: 0.3, animations: { () -> Void in
                self.alpha = 1.0
                self.transform = CGAffineTransform.identity
            })
            
        } else {
            
            self.alpha = 1.0
        }
        
        indicatorView.startAnimating()
    }
    
    open func hide(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.alpha = 0.0
                if self.animationType == ProgressHUDAnimation.zoomIn {
                    self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                } else if self.animationType == ProgressHUDAnimation.zoomOut {
                    self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
            }, completion: { (finished) -> Void in
                self.done(finished)
            })
        } else {
            self.alpha = 0.0
            self.done(true)
        }
    }
    
    open func hide(_ animated: Bool, afterDelay: TimeInterval) {
        self.perform(#selector(ProgressHUD.hideDelayed(_:)), with: NSNumber(value: animated as Bool), afterDelay: afterDelay)
    }
    
    @objc fileprivate func hideDelayed(_ animated: NSNumber) {
        self.hide(animated.boolValue)
    }
    
    fileprivate func done(_ isFinished: Bool) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        self.indicatorView.stopAnimating()
        
        if removeFromSuperViewOnHide {
            self.removeFromSuperview()
        }
        
        if let completionHandler = completionHandler {
            completionHandler()
            self.completionHandler = nil
        }
        
        self.delegate?.hudDidHidden(self)
    }
    
}

extension UIView {
    
    /**
     Creates a new HUD, adds it to provided view and shows it.
     
     - parameter animated: animated If set to YES the HUD will appear using the current animationType. If set to NO the HUD will not use
     
     - returns: A reference to the created HUD.
     */
    func showHUD(_ animated: Bool) -> ProgressHUD {
        let hud = ProgressHUD(frame: self.frame)
        self.addSubview(hud)
        hud.removeFromSuperViewOnHide = true
        hud.show(animated)
        return hud
    }
    
    func showHUD(_ animated: Bool, type: NVActivityIndicatorType, color: UIColor) -> ProgressHUD {
        let hud = ProgressHUD(frame: self.frame, type: type, color: color)
        self.addSubview(hud)
        hud.removeFromSuperViewOnHide = true
        hud.show(animated)
        return hud
    }
    
    /**
     Finds the top-most HUD subview and hides it.
     
     - parameter animated: animated If set to YES the HUD will disappear using the current animationType. If set to NO the HUD will not use
     
     - returns: YES if a HUD was found and removed, NO otherwise.
     */
    func hideHUD(_ animated: Bool) -> Bool {
        for view in self.subviews.reversed() {
            let aMirror = Mirror(reflecting: view)
            if String(describing: aMirror.subjectType) == ProgressHUD.SubjectType {
                
                guard let hud = view as? ProgressHUD else {
                    return false
                }
                
                hud.hide(animated)
                return true
            }
        }
        return false
    }
    
    /**
     Creates a new Indicator, adds it to provided view and shows it.
     
     - parameter animated: animated If set to YES the HUD will disappear using the current animationType. If set to NO the HUD will not use
     - parameter type:     indicator type, value of NVActivityIndicatorType enum.
     - parameter color:    indicator color.
     
     - returns: A reference to the created HUD.
     */
    func showHUDIndicator(_ animated: Bool, type: NVActivityIndicatorType = NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor = UIColor.white) -> ProgressHUD {
        let hud = ProgressHUD(frame: self.frame, type: type, color: color)
        self.addSubview(hud)
        hud.showIndicatorOnly = true
        hud.removeFromSuperViewOnHide = true
        hud.show(animated)
        return hud
    }
}

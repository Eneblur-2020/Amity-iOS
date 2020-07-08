//
//  View.swift
//  InfiHeal
//
//  Created by Suhas Patil on 06/11/19.
//  Copyright © 2019 FIGmd Inc. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
    
    func clearBackgrounds() {
        self.backgroundColor = UIColor.clear
        for subview in self.subviews {
            subview.clearBackgrounds()
        }
    }
    
    /**
     This will give the x coordinate of the view
     - Returns: The x Coordinate
     */
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    /**
     This will give the y coordinate of the view
     - Returns: The y Coordinate
     */
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    /**
     This will give the width of the view
     - Returns: The width
     */
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    /**
     This will give the height of the view
     - Returns: The height
     */
    func height() -> CGFloat {
        return self.frame.size.height
    }
    
    /**
     This will give the bounds width of the view
     - Returns: The width
     */
    func boundsWidth() -> CGFloat {
        return self.bounds.size.width
    }
    
    /**
     This will give thebounds  height of the view
     - Returns: The height
     */
    func boundsHeight() -> CGFloat {
        return self.bounds.size.height
    }

    /**
     This will set the height of the view
     - Parameter width: The width of the view to be modified into
     */
    func setHeight(_ height: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
    }
    
    /**
     This will set the width of the view
     - Parameter width: The width of the view to be modified into
     */
    func setWidth(_ width: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
    }
    
    /**
     This will set the x coordinate of the view
     - Parameter width: The x coordinate of the view to be modified into
     */
    func setX(_ x: CGFloat) {
        self.frame = CGRect(x: x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    /**
     This will set the y coordinate of the view
     - Parameter width: The x coordinate of the view to be modified into
     */
    func setY(_ y: CGFloat) {
        self.frame = CGRect(x: self.frame.origin.x, y: y, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func shake() {
        let transformAnim  = CAKeyframeAnimation(keyPath: "transform")
        transformAnim.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.04, 0.0, 0.0, 1.0)), NSValue(caTransform3D: CATransform3DMakeRotation(-0.04, 0, 0, 1))]
        transformAnim.autoreverses = true
        transformAnim.duration  = 0.115 //(Double(indexPath.row) % 2) == 0 ?   0.115 : 0.105
        transformAnim.repeatCount = Float.infinity
        self.layer.add(transformAnim, forKey: "transform")
    }
    
    func viewHideShow(hidden: Bool) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
    
    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var layerBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /// Function adds shadow to all sides of the View
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: CGFloat(-1), height: CGFloat(1))
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
    }
    
    /// Function adds shadow to right and bottom side of the View
    func addShadowToRightAndBottom() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: CGFloat(10), height: CGFloat(10))
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
    }
    
    func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    
    func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    
    func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    
    func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    private func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
   
}

@IBDesignable extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
}

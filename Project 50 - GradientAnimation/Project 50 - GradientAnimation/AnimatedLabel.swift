//
//  AnimatedLabel.swift
//  Project 50 - GradientAnimation
//
//  Created by 陈炯 on 16/8/21.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

@IBDesignable

class AnimatedLabel: UIView {
    
    struct Constants {
        struct Fonts {
            static let animatedLabel = "HelveticaNeue-UltraLight"
        }
    }
    
    let gradientLayer: CAGradientLayer = {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [UIColor.grayColor().CGColor, UIColor.whiteColor().CGColor, UIColor.grayColor().CGColor, UIColor.whiteColor().CGColor, UIColor.grayColor().CGColor]
        gradientLayer.colors = colors
        
        let locations = [0.00, 0.25, 0.50, 0.75, 1.00]
        gradientLayer.locations = locations
        
        return gradientLayer
    }()
    
    let textAttributes: [String: AnyObject] = {
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        return [NSFontAttributeName: UIFont(name: Constants.Fonts.animatedLabel, size: 50)!, NSParagraphStyleAttributeName: style]
    }()
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            text.drawInRect(bounds, withAttributes: textAttributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clearColor().CGColor
            maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
            maskLayer.contents = image.CGImage
            
            gradientLayer.mask = maskLayer
            
        }
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: bounds.size.width * 2, height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25, 0.25, 0.25]
        gradientAnimation.toValue = [0.75, 1.0, 1.0, 1.0, 1.0]
        gradientAnimation.duration = 1.9
        gradientAnimation.repeatCount = 100
        gradientAnimation.removedOnCompletion = false
        gradientAnimation.fillMode = kCAFillModeForwards
        
        gradientLayer.addAnimation(gradientAnimation, forKey: nil)
    }
    
    
}

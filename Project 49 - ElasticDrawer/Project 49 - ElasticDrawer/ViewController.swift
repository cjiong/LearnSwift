//
//  ViewController.swift
//  Project 49 - ElasticDrawer
//
//  Created by 陈炯 on 16/8/19.
//  Copyright © 2016年 Jiong. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    private let controlPointRatio: CGFloat = 0.6
    private let controlPointPulledDistance: CGFloat = 80
    private let controlPointRoundedDistance: CGFloat = 120
    private let extendedEdgesOffset: CGFloat = 100
    private let captureDistance: CGFloat = 80
    private let thresholdRatio: CGFloat = 0.6
    private let drawerWidth: CGFloat = 240
    
    enum State {
        case Collapsed
        case Expanded
    }
    
    var tracking: Bool = false
    var state: State = .Collapsed
    
    var overlayView = UIView()
    var shapeLayer = CAShapeLayer()
    var drawerViewVC: DrawerTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("drawer") as! DrawerTableViewController
    
    func createPulledPath(width: CGFloat, point: CGPoint) -> UIBezierPath {
        let height = view.bounds.height
        let offset = width + point.x
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: -extendedEdgesOffset, y: -extendedEdgesOffset))
        path.addLineToPoint(CGPoint(x: width, y: -extendedEdgesOffset))
        
        path.addCurveToPoint(CGPoint(x: offset, y: point.y),
            controlPoint1: CGPoint(x: width, y: point.y * controlPointRatio),
            controlPoint2: CGPoint(x: offset, y: point.y - controlPointPulledDistance))
        
        path.addCurveToPoint(CGPoint(x: width, y: height + extendedEdgesOffset),
            controlPoint1: CGPoint(x: offset, y: point.y + controlPointPulledDistance),
            controlPoint2: CGPoint(x: width, y: point.y + (height - point.y) * 0.4))
        
        path.addLineToPoint(CGPoint(x: -extendedEdgesOffset, y: height + extendedEdgesOffset))
        path.closePath()
        
        return path
    }
    
    func createRoundedPath(width: CGFloat, point: CGPoint) -> UIBezierPath {
        let height = view.bounds.height
        let offset = width + point.x
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointZero)
        path.addLineToPoint(CGPoint(x: width, y: 0))
        
        path.addCurveToPoint(CGPoint(x: offset, y: point.y),
            controlPoint1: CGPoint(x: width, y: 0),
            controlPoint2: CGPoint(x: offset, y: point.y - controlPointRoundedDistance))
        
        path.addCurveToPoint(CGPoint(x: width, y: height),
            controlPoint1: CGPoint(x: offset, y: point.y + controlPointRoundedDistance),
            controlPoint2: CGPoint(x: width, y: height))
        
        path.addLineToPoint(CGPoint(x: 0, y: height))
        path.closePath()
        
        return path
    }
    
    func animateShapeLayerToPath(path: CGPathRef, duration: NSTimeInterval) {
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = path
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.8, 1, 1)
        
        shapeLayer.addAnimation(animation, forKey: "morph")
    }
    
    func animateShapeLayerWithKeyFrames(values: [AnyObject], times: [Float], duration: NSTimeInterval) {
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "path")
        keyFrameAnimation.duration = duration
        keyFrameAnimation.fillMode = kCAFillModeForwards
        keyFrameAnimation.removedOnCompletion = false
        keyFrameAnimation.values = values
        keyFrameAnimation.keyTimes = times
        
        shapeLayer.addAnimation(keyFrameAnimation, forKey: "morph")
    }
    
    func handlePan(pan: UIPanGestureRecognizer) {
        let location = pan.locationInView(view)
        
        switch pan.state {
        case .Began:
            shapeLayer.removeAllAnimations()
            if state == .Collapsed && location.x < captureDistance {
                tracking = true
            } else if state == .Expanded && location.x > drawerWidth - captureDistance {
                tracking = true
            } else {
                shapeLayer.path = nil
            }
            
            if tracking {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    [self]
                    self.overlayView.alpha = 1
                    }, completion: nil)
                
                fallthrough
            }
            
        case .Changed:
            if !tracking {
                return
            }
            
            if state == .Collapsed && location.x > thresholdRatio * drawerWidth {
                tracking = false
                
                let centerY = view.bounds.height / 2
                animateShapeLayerWithKeyFrames([
                    shapeLayer.path!,
                    createRoundedPath(drawerWidth, point: CGPoint(x: 30, y: (location.y+centerY)/2)).CGPath,
                    createRoundedPath(drawerWidth, point: CGPoint(x: -30, y: centerY)).CGPath,
                    createRoundedPath(drawerWidth, point: CGPoint(x: 0, y: centerY)).CGPath
                    ], times: [0, 0.5, 0.8, 1.0], duration: 0.3)
                state = .Expanded
            } else if state == .Expanded && location.x < (1 - thresholdRatio) * drawerWidth {
                tracking = false
                
                let centerY = view.bounds.height / 2
                animateShapeLayerWithKeyFrames([
                    shapeLayer.path!,
                    createRoundedPath(0, point: CGPoint(x: -30, y: (location.y+centerY) / 2)).CGPath,
                    createRoundedPath(0, point: CGPoint(x: 30, y: centerY)).CGPath,
                    createRoundedPath(0, point: CGPoint(x: 0, y: centerY)).CGPath
                    ], times: [0, 0.5, 0.8, 1.0], duration: 0.3)
                state = .Collapsed
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    [self]
                    self.overlayView.alpha = 0
                    }, completion: nil)
            } else {
                if state == .Collapsed {
                    
                    shapeLayer.path = createPulledPath(0, point: CGPoint(x: location.x * 0.5, y: location.y)).CGPath
                } else {

                    shapeLayer.path = createPulledPath(drawerWidth, point: CGPoint(x: -max(0, drawerWidth - location.x) * 0.5, y: location.y)).CGPath
                }
            }
            
        case .Ended:
            fallthrough
            
        case .Cancelled:
            if tracking {
                
                animateShapeLayerToPath(createPulledPath(state == .Collapsed ? 0 : drawerWidth, point: CGPoint(x: 0, y: location.y)).CGPath, duration: 0.2)
                tracking = false
                
                if state == .Collapsed {
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                        [self]
                        self.overlayView.alpha = 0
                        }, completion: nil)
                }
            }
            
        default:
            ()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.grayColor()
        
        view.addSubview(overlayView)
        view.addSubview(drawerViewVC.view)
        drawerViewVC.view.layer.mask = shapeLayer
        overlayView.alpha = 0
        
        let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
        view.addGestureRecognizer(pan)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillLayoutSubviews() {
        overlayView.frame = view.bounds
        drawerViewVC.view.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


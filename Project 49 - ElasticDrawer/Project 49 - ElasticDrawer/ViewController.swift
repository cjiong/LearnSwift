//
//  ViewController.swift
//  Project 49 - ElasticDrawer
//
//  Created by 陈炯 on 16/8/19.
//  Copyright © 2016年 Jiong. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    fileprivate let controlPointRatio: CGFloat = 0.6
    fileprivate let controlPointPulledDistance: CGFloat = 80
    fileprivate let controlPointRoundedDistance: CGFloat = 120
    fileprivate let extendedEdgesOffset: CGFloat = 100
    fileprivate let captureDistance: CGFloat = 80
    fileprivate let thresholdRatio: CGFloat = 0.6
    fileprivate let drawerWidth: CGFloat = 240
    
    enum State {
        case collapsed
        case expanded
    }
    
    var tracking: Bool = false
    var state: State = .collapsed
    
    var overlayView = UIView()
    var shapeLayer = CAShapeLayer()
    var drawerViewVC: DrawerTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "drawer") as! DrawerTableViewController
    
    func createPulledPath(_ width: CGFloat, point: CGPoint) -> UIBezierPath {
        let height = view.bounds.height
        let offset = width + point.x
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -extendedEdgesOffset, y: -extendedEdgesOffset))
        path.addLine(to: CGPoint(x: width, y: -extendedEdgesOffset))
        
        path.addCurve(to: CGPoint(x: offset, y: point.y),
            controlPoint1: CGPoint(x: width, y: point.y * controlPointRatio),
            controlPoint2: CGPoint(x: offset, y: point.y - controlPointPulledDistance))
        
        path.addCurve(to: CGPoint(x: width, y: height + extendedEdgesOffset),
            controlPoint1: CGPoint(x: offset, y: point.y + controlPointPulledDistance),
            controlPoint2: CGPoint(x: width, y: point.y + (height - point.y) * 0.4))
        
        path.addLine(to: CGPoint(x: -extendedEdgesOffset, y: height + extendedEdgesOffset))
        path.close()
        
        return path
    }
    
    func createRoundedPath(_ width: CGFloat, point: CGPoint) -> UIBezierPath {
        let height = view.bounds.height
        let offset = width + point.x
        
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: width, y: 0))
        
        path.addCurve(to: CGPoint(x: offset, y: point.y),
            controlPoint1: CGPoint(x: width, y: 0),
            controlPoint2: CGPoint(x: offset, y: point.y - controlPointRoundedDistance))
        
        path.addCurve(to: CGPoint(x: width, y: height),
            controlPoint1: CGPoint(x: offset, y: point.y + controlPointRoundedDistance),
            controlPoint2: CGPoint(x: width, y: height))
        
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        
        return path
    }
    
    func animateShapeLayerToPath(_ path: CGPath, duration: TimeInterval) {
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = path
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.8, 1, 1)
        
        shapeLayer.add(animation, forKey: "morph")
    }
    
    func animateShapeLayerWithKeyFrames(_ values: [AnyObject], times: [Float], duration: TimeInterval) {
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "path")
        keyFrameAnimation.duration = duration
        keyFrameAnimation.fillMode = kCAFillModeForwards
        keyFrameAnimation.isRemovedOnCompletion = false
        keyFrameAnimation.values = values
        keyFrameAnimation.keyTimes = times as [NSNumber]?
        
        shapeLayer.add(keyFrameAnimation, forKey: "morph")
    }
    
    func handlePan(_ pan: UIPanGestureRecognizer) {
        let location = pan.location(in: view)
        
        switch pan.state {
        case .began:
            shapeLayer.removeAllAnimations()
            if state == .collapsed && location.x < captureDistance {
                tracking = true
            } else if state == .expanded && location.x > drawerWidth - captureDistance {
                tracking = true
            } else {
                shapeLayer.path = nil
            }
            
            if tracking {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    
                    self.overlayView.alpha = 1
                    }, completion: nil)
                
                fallthrough
            }
            
        case .changed:
            if !tracking {
                return
            }
            
            if state == .collapsed && location.x > thresholdRatio * drawerWidth {
                tracking = false
                
                let centerY = view.bounds.height / 2
                animateShapeLayerWithKeyFrames([
                    shapeLayer.path!,
                    createRoundedPath(drawerWidth, point: CGPoint(x: 30, y: (location.y+centerY)/2)).cgPath,
                    createRoundedPath(drawerWidth, point: CGPoint(x: -30, y: centerY)).cgPath,
                    createRoundedPath(drawerWidth, point: CGPoint(x: 0, y: centerY)).cgPath
                    ], times: [0, 0.5, 0.8, 1.0], duration: 0.3)
                state = .expanded
            } else if state == .expanded && location.x < (1 - thresholdRatio) * drawerWidth {
                tracking = false
                
                let centerY = view.bounds.height / 2
                animateShapeLayerWithKeyFrames([
                    shapeLayer.path!,
                    createRoundedPath(0, point: CGPoint(x: -30, y: (location.y+centerY) / 2)).cgPath,
                    createRoundedPath(0, point: CGPoint(x: 30, y: centerY)).cgPath,
                    createRoundedPath(0, point: CGPoint(x: 0, y: centerY)).cgPath
                    ], times: [0, 0.5, 0.8, 1.0], duration: 0.3)
                state = .collapsed
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    
                    self.overlayView.alpha = 0
                    }, completion: nil)
            } else {
                if state == .collapsed {
                    
                    shapeLayer.path = createPulledPath(0, point: CGPoint(x: location.x * 0.5, y: location.y)).cgPath
                } else {

                    shapeLayer.path = createPulledPath(drawerWidth, point: CGPoint(x: -max(0, drawerWidth - location.x) * 0.5, y: location.y)).cgPath
                }
            }
            
        case .ended:
            fallthrough
            
        case .cancelled:
            if tracking {
                
                animateShapeLayerToPath(createPulledPath(state == .collapsed ? 0 : drawerWidth, point: CGPoint(x: 0, y: location.y)).cgPath, duration: 0.2)
                tracking = false
                
                if state == .collapsed {
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                        
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
        
        self.view.backgroundColor = UIColor.gray
        
        view.addSubview(overlayView)
        view.addSubview(drawerViewVC.view)
        drawerViewVC.view.layer.mask = shapeLayer
        overlayView.alpha = 0
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(_:)))
        view.addGestureRecognizer(pan)
    }
    
    override var prefersStatusBarHidden : Bool {
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


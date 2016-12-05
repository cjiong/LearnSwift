//
//  ZoomingIconTransition.swift
//  Project 48 - ZoomingIcons
//
//  Created by Matthew Cheok on 31/10/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//


import UIKit

private let kZoomingIconTransitionDuration: TimeInterval = 0.6
private let kZoomingIconTransitionZoomedScale: CGFloat = 15
private let kZoomingIconTransitionBackgroundScale: CGFloat = 0.80

class ZoomingIconTransition: NSObject, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning {
    var operation: UINavigationControllerOperation = .none
    
    enum TransitionState {
        case initial
        case final
    }
    
    typealias ZoomingViews = (coloredView: UIView, imageView: UIView)
    
    func configureViewsForState(_ state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            
            snapshotViews.coloredView.transform = CGAffineTransform.identity
            snapshotViews.coloredView.frame = containerView.convert(viewsInBackground.coloredView.frame, from: viewsInBackground.coloredView.superview)
            snapshotViews.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
            
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: kZoomingIconTransitionBackgroundScale, y: kZoomingIconTransitionBackgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.coloredView.transform = CGAffineTransform(scaleX: kZoomingIconTransitionZoomedScale, y: kZoomingIconTransitionZoomedScale)
            snapshotViews.coloredView.center = containerView.convert(viewsInForeground.imageView.center, from: viewsInForeground.imageView.superview)
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
            
            
            ()
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kZoomingIconTransitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        // get the image view in the background and foreground view controllers
        
        let backgroundImageViewMaybe = (backgroundViewController as? ZoomingIconViewController)?.zoomingIconImageViewForTransition(self)
        let foregroundImageViewMaybe = (foregroundViewController as? ZoomingIconViewController)?.zoomingIconImageViewForTransition(self)
        
        assert(backgroundImageViewMaybe != nil, "Cannot find image view in background view controller")
        assert(foregroundImageViewMaybe != nil, "Cannot find image view in foreground view controller")
        
        let backgroundImageView = backgroundImageViewMaybe!
        let foregroundImageView = foregroundImageViewMaybe!
        
        // get the colored view in the background and foreground view controllers
        
        let backgroundColoredViewMaybe = (backgroundViewController as? ZoomingIconViewController)?.zoomingIconColoredViewForTransition(self)
        let foregroundColoredViewMaybe = (foregroundViewController as? ZoomingIconViewController)?.zoomingIconColoredViewForTransition(self)
        
        assert(backgroundColoredViewMaybe != nil, "Cannot find colored view in background view controller")
        assert(foregroundColoredViewMaybe != nil, "Cannot find colored view in foreground view controller")
        
        let backgroundColoredView = backgroundColoredViewMaybe!
        let foregroundColoredView = foregroundColoredViewMaybe!
        
        // create view snapshots
        // view controller need to be in view hierarchy for snapshotting
        containerView.addSubview(backgroundViewController.view)
        let snapshotOfColoredView = backgroundColoredView.snapshotView(afterScreenUpdates: false)
        
        let snapshotOfImageView = UIImageView(image: backgroundImageView.image)
        snapshotOfImageView.contentMode = .scaleAspectFit
        
        // setup animation
        backgroundColoredView.isHidden = true
        foregroundColoredView.isHidden = true
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        
        containerView.backgroundColor = UIColor.white
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(snapshotOfColoredView!)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(snapshotOfImageView)
        
        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = UIColor.clear
        
        var preTransitionState = TransitionState.initial
        var postTransitionState = TransitionState.final
        
        if operation == .pop {
            preTransitionState = TransitionState.final
            postTransitionState = TransitionState.initial
        }
        
        configureViewsForState(preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView!, snapshotOfImageView))
        
        // perform animation
        (backgroundViewController as? ZoomingIconViewController)?.zoomingIconTransition?(self, willAnimateTransitionWithOperation: operation, isForegroundViewController: false)
        (foregroundViewController as? ZoomingIconViewController)?.zoomingIconTransition?(self, willAnimateTransitionWithOperation: operation, isForegroundViewController: true)
        
        // need to layout now if we want the correct parameters for frame
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            
            self.configureViewsForState(postTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView!, snapshotOfImageView))
            
            }, completion: {
                (finished) in
                
                backgroundViewController.view.transform = CGAffineTransform.identity
                
                snapshotOfColoredView?.removeFromSuperview()
                snapshotOfImageView.removeFromSuperview()
                
                backgroundColoredView.isHidden = false
                foregroundColoredView.isHidden = false
                
                backgroundImageView.isHidden = false
                foregroundImageView.isHidden = false
                
                foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // protocol needs to be @objc for conformance testing
        if fromVC is ZoomingIconViewController &&
            toVC is ZoomingIconViewController {
                self.operation = operation
                return self
        }
        else {
            return nil
        }
    }
}

@objc
protocol ZoomingIconViewController {
    func zoomingIconColoredViewForTransition(_ transition: ZoomingIconTransition) -> UIView!
    func zoomingIconImageViewForTransition(_ transition: ZoomingIconTransition) -> UIImageView!
    
    @objc optional
    func zoomingIconTransition(_ transition: ZoomingIconTransition, willAnimateTransitionWithOperation operation: UINavigationControllerOperation, isForegroundViewController isForeground: Bool)
}

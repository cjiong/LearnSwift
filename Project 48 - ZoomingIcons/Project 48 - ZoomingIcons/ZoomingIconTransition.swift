//
//  ZoomingIconTransition.swift
//  Project 48 - ZoomingIcons
//
//  Created by Matthew Cheok on 31/10/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//


import UIKit

private let kZoomingIconTransitionDuration: NSTimeInterval = 0.6
private let kZoomingIconTransitionZoomedScale: CGFloat = 15
private let kZoomingIconTransitionBackgroundScale: CGFloat = 0.80

class ZoomingIconTransition: NSObject, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning {
    var operation: UINavigationControllerOperation = .None
    
    enum TransitionState {
        case Initial
        case Final
    }
    
    typealias ZoomingViews = (coloredView: UIView, imageView: UIView)
    
    func configureViewsForState(state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
        case .Initial:
            backgroundViewController.view.transform = CGAffineTransformIdentity
            backgroundViewController.view.alpha = 1
            
            snapshotViews.coloredView.transform = CGAffineTransformIdentity
            snapshotViews.coloredView.frame = containerView.convertRect(viewsInBackground.coloredView.frame, fromView: viewsInBackground.coloredView.superview)
            snapshotViews.imageView.frame = containerView.convertRect(viewsInBackground.imageView.frame, fromView: viewsInBackground.imageView.superview)
            
        case .Final:
            backgroundViewController.view.transform = CGAffineTransformMakeScale(kZoomingIconTransitionBackgroundScale, kZoomingIconTransitionBackgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.coloredView.transform = CGAffineTransformMakeScale(kZoomingIconTransitionZoomedScale, kZoomingIconTransitionZoomedScale)
            snapshotViews.coloredView.center = containerView.convertPoint(viewsInForeground.imageView.center, fromView: viewsInForeground.imageView.superview)
            snapshotViews.imageView.frame = containerView.convertRect(viewsInForeground.imageView.frame, fromView: viewsInForeground.imageView.superview)
            
            
            ()
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return kZoomingIconTransitionDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(transitionContext)
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .Pop {
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
        containerView!.addSubview(backgroundViewController.view)
        let snapshotOfColoredView = backgroundColoredView.snapshotViewAfterScreenUpdates(false)
        
        let snapshotOfImageView = UIImageView(image: backgroundImageView.image)
        snapshotOfImageView.contentMode = .ScaleAspectFit
        
        // setup animation
        backgroundColoredView.hidden = true
        foregroundColoredView.hidden = true
        
        backgroundImageView.hidden = true
        foregroundImageView.hidden = true
        
        containerView!.backgroundColor = UIColor.whiteColor()
        containerView!.addSubview(backgroundViewController.view)
        containerView!.addSubview(snapshotOfColoredView)
        containerView!.addSubview(foregroundViewController.view)
        containerView!.addSubview(snapshotOfImageView)
        
        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = UIColor.clearColor()
        
        var preTransitionState = TransitionState.Initial
        var postTransitionState = TransitionState.Final
        
        if operation == .Pop {
            preTransitionState = TransitionState.Final
            postTransitionState = TransitionState.Initial
        }
        
        configureViewsForState(preTransitionState, containerView: containerView!, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView, snapshotOfImageView))
        
        // perform animation
        (backgroundViewController as? ZoomingIconViewController)?.zoomingIconTransition?(self, willAnimateTransitionWithOperation: operation, isForegroundViewController: false)
        (foregroundViewController as? ZoomingIconViewController)?.zoomingIconTransition?(self, willAnimateTransitionWithOperation: operation, isForegroundViewController: true)
        
        // need to layout now if we want the correct parameters for frame
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            [self]
            self.configureViewsForState(postTransitionState, containerView: containerView!, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView, snapshotOfImageView))
            
            }, completion: {
                (finished) in
                
                backgroundViewController.view.transform = CGAffineTransformIdentity
                
                snapshotOfColoredView.removeFromSuperview()
                snapshotOfImageView.removeFromSuperview()
                
                backgroundColoredView.hidden = false
                foregroundColoredView.hidden = false
                
                backgroundImageView.hidden = false
                foregroundImageView.hidden = false
                
                foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
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
    func zoomingIconColoredViewForTransition(transition: ZoomingIconTransition) -> UIView!
    func zoomingIconImageViewForTransition(transition: ZoomingIconTransition) -> UIImageView!
    
    optional
    func zoomingIconTransition(transition: ZoomingIconTransition, willAnimateTransitionWithOperation operation: UINavigationControllerOperation, isForegroundViewController isForeground: Bool)
}
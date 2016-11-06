//  SwipeTransitionAnimator.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/4/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

class SwipeTransitionAnimator:NSObject, UIViewControllerAnimatedTransitioning {
    var targetEdge:UIRectEdge?
    // MARK: - Initialization
    convenience init(targetEdge:UIRectEdge) {
        self.init()
        self.targetEdge = targetEdge
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: -
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            else {
                return
        }
        
        let isPresenting = (toViewController.presentingViewController == fromViewController)
        let containerView = transitionContext.containerView
        let fromFrame = transitionContext.initialFrame(for: fromViewController)
        let toFrame = transitionContext.finalFrame(for: toViewController)
        
        var offset:CGVector = CGVectorFromString("{0, 0}")
        
        if (self.targetEdge == UIRectEdge.top) {
            offset = CGVector(dx: 0.0, dy: 1.0)
        } else if (self.targetEdge == UIRectEdge.bottom) {
            offset = CGVector(dx:0.0, dy:-1.0)
        } else if (self.targetEdge == UIRectEdge.left) {
            offset = CGVector(dx:1.0, dy:0.0)
        } else if (self.targetEdge == UIRectEdge.right) {
            offset = CGVector(dx:-1.0, dy:0.0)
        } else {
            assert(false, "targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        }
        
        
        if (isPresenting) {
            // For a presentation, the toView starts off-screen and slides in.
            fromView.frame = fromFrame;
            let dx = toFrame.size.width * offset.dx * -1
            let dy = toFrame.size.height * offset.dy * -1
            toView.frame = toView.frame.offsetBy(dx:dx , dy:dy)
        } else {
            fromView.frame = fromFrame;
            toView.frame = toFrame;
        }
        
        if (isPresenting) {
            containerView.addSubview(toView)
        } else {
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, animations: {
            if (isPresenting) {
                toView.frame = toFrame;
            } else {
                // For a dismissal, the fromView slides off the screen.
                let dx = fromFrame.size.width * offset.dx
                let dy = fromFrame.size.height * offset.dy
                fromView.frame = fromView.frame.offsetBy(dx:dx , dy:dy )
            }
        }, completion: {finished in
            let wasCancelled = transitionContext.transitionWasCancelled
            if (wasCancelled) {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(!wasCancelled)
        })
    }
}

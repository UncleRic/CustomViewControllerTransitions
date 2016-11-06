//  SwipeTransitionDelegate.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/4/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class SwipeTransitionDelegate:NSObject, UIViewControllerTransitioningDelegate {
    
    var gestureRecognizer:UIScreenEdgePanGestureRecognizer?
    var targetEdge:UIRectEdge?
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransitionAnimator(targetEdge: self.targetEdge!)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransitionAnimator(targetEdge: self.targetEdge!)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if ((self.gestureRecognizer) != nil) {
            return SwipeTransitionInteractionController(gestureRecognizer: self.gestureRecognizer!, edgeForDragging: self.targetEdge!)
        } else {
            return nil
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if ((self.gestureRecognizer) != nil) {
            return SwipeTransitionInteractionController(gestureRecognizer: self.gestureRecognizer!, edgeForDragging: self.targetEdge!)
        } else {
            return nil
        }
    }
}


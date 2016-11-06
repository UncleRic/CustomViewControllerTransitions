//  SwipeTransitionInteractionController.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/4/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

class SwipeTransitionInteractionController : UIPercentDrivenInteractiveTransition {
    var gestureRecognizer:UIScreenEdgePanGestureRecognizer!
    var transitioningContext:UIViewControllerContextTransitioning!
    var edge:UIRectEdge!
    
    // MARK: - Initialization
    
    convenience init(gestureRecognizer:UIScreenEdgePanGestureRecognizer, edgeForDragging edge:UIRectEdge) {
        self.init()
        let isEdgeChecked = (edge == UIRectEdge.top || edge == UIRectEdge.bottom || edge == UIRectEdge.left || edge == UIRectEdge.right)
        assert(isEdgeChecked, "edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        self.gestureRecognizer = gestureRecognizer
        self.edge = edge
        self.gestureRecognizer.addTarget(self, action: #selector(handleGestureRecognizer))
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    deinit {
        self.gestureRecognizer.removeTarget(self, action: #selector(handleGestureRecognizer))
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func startInteractiveTransition(transitionContext:UIViewControllerContextTransitioning) {
        self.transitioningContext = transitionContext
        super.startInteractiveTransition(transitionContext)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func percentForGesture(gesture:UIScreenEdgePanGestureRecognizer) -> CGFloat {
        let transitionContainerView = self.transitioningContext.containerView
        let locationInSourceView = gesture.location(in:self.transitioningContext.containerView)
        let width:CGFloat = transitionContainerView.bounds.width
        let height:CGFloat = transitionContainerView.bounds.height
        
        if (self.edge == UIRectEdge.right) {
            return (width - locationInSourceView.x) / width;
        } else if (self.edge == UIRectEdge.left) {
            return locationInSourceView.x / width;
        } else if (self.edge == UIRectEdge.bottom) {
            return (height - locationInSourceView.y) / height;
        } else if (self.edge == UIRectEdge.top) {
            return locationInSourceView.y / height;
        } else {
            return 0.0
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Gesture Handler
    
    func handleGestureRecognizer(gestureRecognizer:UIScreenEdgePanGestureRecognizer) {
        switch (gestureRecognizer.state) {
        case UIGestureRecognizerState.began:
            break
        case UIGestureRecognizerState.changed:
            self.update(self.percentForGesture(gesture: gestureRecognizer))
            break
        case UIGestureRecognizerState.ended:
            if (self.percentForGesture(gesture: gestureRecognizer) >= 0.5) {
                self.finish()
            } else {
                self.cancel()
            }
            break
        default:
            self.cancel()
        }
    }
}





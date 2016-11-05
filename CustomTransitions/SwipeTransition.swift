//  SwipeTransition.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/4/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class SwipeTransition:UIPercentDrivenInteractiveTransition {
    
    var gestureRecognizer:UIPanGestureRecognizer?
    var transitionContext:UIViewControllerContextTransitioning?
    var edge:UIRectEdge?
    
    // MARK: - Initialization
    
    convenience init(gestureRecognizer:UIPanGestureRecognizer) {
        self.init()
        self.gestureRecognizer = gestureRecognizer
        gestureRecognizer.addTarget(self, action: #selector(gestureRecognizeDidUpdate))
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    deinit {
        self.gestureRecognizer?.removeTarget(self, action: #selector(gestureRecognizeDidUpdate))
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext;
        super.startInteractiveTransition(transitionContext)
    }
    
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Gesture Handler
    
    func gestureRecognizeDidUpdate(gestureRecognizer:UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.began:
            break
        case UIGestureRecognizerState.changed:
            // We have been dragging! Update the transition context accordingly.
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
            break
        }
    }
    
    // ----------------------------------------------------------------------------
    
    func percentForGesture(gesture:UIScreenEdgePanGestureRecognizer) -> CGFloat {
        let transitionContainerView = self.transitionContext?.containerView
        let locationInSourceView = gesture.location(in: transitionContainerView)
        let width = (transitionContainerView?.bounds)!.width
        let height = (transitionContainerView?.bounds)!.height
        
        
        if (self.edge == UIRectEdge.right) {
            return (width - locationInSourceView.x) / width;
        } else if (self.edge == UIRectEdge.left) {
            return locationInSourceView.x / width;
        } else if (self.edge == UIRectEdge.bottom) {
            return (height - locationInSourceView.y) / height;
        } else if (self.edge == UIRectEdge.top) {
            return locationInSourceView.y / height;
        } else {
            return 0;
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    - (instancetype)initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer*)gestureRecognizer edgeForDragging:(UIRectEdge)edge NS_DESIGNATED_INITIALIZER;
    //
    //    - (instancetype)init NS_UNAVAILABLE;
    
    convenience init(gestureRecognizer:UIScreenEdgePanGestureRecognizer, edgeForDragging edge:UIRectEdge){
        self.init()
        
        let condition = (edge == UIRectEdge.top || edge == UIRectEdge.bottom || edge == UIRectEdge.left || edge == UIRectEdge.right)
        
        assert(condition,"Warning: 'edgeForDragging' must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        
        
    }
    
}


//  Swipe.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/4/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class SwipeFirstViewController:UIViewController {
    
    // Lazy load:
    var swipeTransitionDelegate:SwipeTransitionDelegate? {
        if nil == self.swipeTransitionDelegate {
            return SwipeTransitionDelegate()
        }
        return self.swipeTransitionDelegate
    }
    
    override func viewDidLoad() {
        let interactiveTransitionRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture))
         interactiveTransitionRecognizer.edges = UIRectEdge.right;
        
        
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
    }

    // -----------------------------------------------------------------------------------------------------
    // MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Do Something
        if segue.identifier == "CustomTransition" {
            let destinationViewController = segue.destination
            let transitionDelegate = self.swipeTransitionDelegate
            
            
//            if sender is UIGestureRecognizer {
//                swipeTransitionDelegate!.gestureRecognizer = sender;
//            } else {
//                swipeTransitionDelegate!.gestureRecognizer = nil;
//
//            }
            
//            if ([sender isKindOfClass:UIGestureRecognizer.class])
//            transitionDelegate.gestureRecognizer = sender;
//            else
//            transitionDelegate.gestureRecognizer = nil;

            
           // interactiveTransitionRecognizer.gestureRecognizer = sender
        }
        
//        if ([segue.identifier isEqualToString:@"CustomTransition"])
//        {
//            UIViewController *destinationViewController = segue.destinationViewController;
//            
//            // Unlike in the Cross Dissolve demo, we use a separate object as the
//            // transition delegate rather then (our)self.  This promotes
//            // 'separation of concerns' as AAPLSwipeTransitionDelegate will
//            // handle pairing the correct animation controller and interaction
//            // controller for the presentation.
//            AAPLSwipeTransitionDelegate *transitionDelegate = self.customTransitionDelegate;
//            
//            // If this will be an interactive presentation, pass the gesture
//            // recognizer along to our AAPLSwipeTransitionDelegate instance
//            // so it can return the necessary
//            // <UIViewControllerInteractiveTransitioning> for the presentation.
        
        
//            if ([sender isKindOfClass:UIGestureRecognizer.class])
//            transitionDelegate.gestureRecognizer = sender;
//            else
//            transitionDelegate.gestureRecognizer = nil;
//            
//            // Set the edge of the screen to present the incoming view controller
//            // from.  This will match the edge we configured the
//            // UIScreenEdgePanGestureRecognizer with previously.
//            //
//            // NOTE: We can not retrieve the value of our gesture recognizer's
//            //       configured edges because prior to iOS 8.3
//            //       UIScreenEdgePanGestureRecognizer would always return
//            //       UIRectEdgeNone when querying its edges property.
//            transitionDelegate.targetEdge = UIRectEdgeRight;
//            
//            // Note that the view controller does not hold a strong reference to
//            // its transitioningDelegate.  If you instantiate a separate object
//            // to be the transitioningDelegate, ensure that you hold a strong
//            // reference to that object.
//            destinationViewController.transitioningDelegate = transitionDelegate;
//            
//            // Setting the modalPresentationStyle to FullScreen enables the
//            // <ContextTransitioning> to provide more accurate initial and final
//            // frames of the participating view controllers.
//            destinationViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//        }

    }
    
    
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action methods
    
    @IBAction func handlePanGesture(sender:UIScreenEdgePanGestureRecognizer) {
        
        
        if (sender.state == UIGestureRecognizerState.began) {
            self.performSegue(withIdentifier: "CustomTransition", sender: sender)
        }
        // Remaining cases are handled by the SwipeTransitionDelegate.
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func unwindToSwipeFirstViewController(sender:UIStoryboardSegue) {
    }
}


// ===================================================================================================

class SwipeSecondViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactiveTransitionRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleTransitionRecognizer))
        interactiveTransitionRecognizer.edges = UIRectEdge.left
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
    }
    
    func handleTransitionRecognizer(sender:UIScreenEdgePanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            self.performSegue(withIdentifier: "BackToFirstViewController", sender: sender)
        }
    }
}



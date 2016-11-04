//  CrossDissolve.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/2/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class CrossDissolveFirstViewController:UIViewController, UIViewControllerTransitioningDelegate {
    @IBAction func presentWithCustomTransitionAction(_ sender: UIButton) {
        guard
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") else {
                print("*** Error: unable to instantiate secondViewController.  ***")
                return
        }
        secondViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        // The transitioning delegate can supply a custom animation controller
        // that will be used to animate the incoming view controller.
        
        secondViewController.transitioningDelegate = self
        
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    

    @IBAction func unwindToCrossDissolveViewController(sender:UIStoryboardSegue) {
        
    }
    
}

// -----------------------------------------------------------------------------------------------------
// MARK: - UIViewControllerTransitioningDelegate

// The system calls this method on the presented view controller's 'transitioningDelegate'
// to tretrieve the animator object used for animating the presentation of the incoming view controller. 
// Your implementation is expected to return an obejcet that confirms to the UIViewControllerAnimatedTransitioning protocol or nil
// if the default presentation animation should be used. 


func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    return CrossDissolveTransitionAnimator()
}


// -----------------------------------------------------------------------------------------------------
// Ditto the above for the dismissal animation of the presented view controller:
func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return CrossDissolveTransitionAnimator()
}

// ===================================================================================================

class CrossDissolveSecondViewController:UIViewController {
    @IBAction func dismissAction(sender:Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// ===================================================================================================


class CrossDissolveTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var fromIndex: Int = 0
    var toIndex: Int = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let containerView = transitionContext.containerView
        
        // For a Presentation:
        //      fromView = The presenting view.
        //      toView   = The presented view.
        // For a Dismissal:
        //      fromView = The presented view.
        //      toView   = The presenting view.
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        fromView?.frame = transitionContext.initialFrame(for: fromViewController!)
        toView?.frame = transitionContext.initialFrame(for: toViewController!)
        
        
        fromView?.alpha = 1.0
        toView?.alpha = 0.0
        
        // We are responsible for adding the incoming view to the containerView
        // for the presentation/dismissal.
        containerView.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, animations: {
            fromView?.alpha = 0.0
            toView?.alpha = 1.0
        }, completion: {finished in
            // When we complete, tell the transition contet passing along the BOOL
            // that indicate wheter the transition finished or not.
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        })
    }
}

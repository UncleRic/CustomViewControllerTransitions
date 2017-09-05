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
    
    var _swipeTransitionDelegate:SwipeTransitionDelegate?
    
    var swipeTransitionDelegate:SwipeTransitionDelegate? {
        if nil == _swipeTransitionDelegate {
            _swipeTransitionDelegate = SwipeTransitionDelegate()
        }
        return _swipeTransitionDelegate
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
            
            
            if sender is UIGestureRecognizer {
                swipeTransitionDelegate!.gestureRecognizer = sender as! UIScreenEdgePanGestureRecognizer?
            } else {
                swipeTransitionDelegate!.gestureRecognizer = nil;
            }
            
            transitionDelegate?.targetEdge = UIRectEdge.right
            destinationViewController.transitioningDelegate = transitionDelegate as UIViewControllerTransitioningDelegate?
            destinationViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        }
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
// MARK:

class SwipeSecondViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactiveTransitionRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleTransitionRecognizer))
        interactiveTransitionRecognizer.edges = UIRectEdge.left
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
    }
    
    @objc func handleTransitionRecognizer(sender:UIScreenEdgePanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            self.performSegue(withIdentifier: "BackToFirstViewController", sender: sender)
        }
    }
    
    
    //| ----------------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToFirstViewController" {
            
            if self.transitioningDelegate is SwipeTransitionDelegate {
                let transitionDelegate:SwipeTransitionDelegate = self.transitioningDelegate as! SwipeTransitionDelegate
                if sender is UIGestureRecognizer {
                    transitionDelegate.gestureRecognizer = sender as? UIScreenEdgePanGestureRecognizer
                } else {
                    transitionDelegate.gestureRecognizer = nil
                }
                transitionDelegate.targetEdge = UIRectEdge.left
            }
        }
    }
}





//  Swipe.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/4/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class SwipeFirstViewController:UIViewController {
    let swipeTransitionDelegate = SwipeTransition()
    override func viewDidLoad() {
        let interactiveTransitionRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture))
         interactiveTransitionRecognizer.edges = UIRectEdge.right;
        
        
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
    }

    // -----------------------------------------------------------------------------------------------------
    // MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Do Something
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action methods
    
    @IBAction func handlePanGesture(sender:UIScreenEdgePanGestureRecognizer) {
        
        
        if (sender.state == UIGestureRecognizerState.began) {
            self.performSegue(withIdentifier: "CustomTransition", sender: sender)
        }
        // Remaining cases are handled by the SwipeTransition.
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



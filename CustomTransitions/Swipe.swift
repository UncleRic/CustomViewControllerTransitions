//  Swipe.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/4/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class SwipeFirstViewController:UIViewController {
    override func viewDidLoad() {
        // ...do something
    }

    // -----------------------------------------------------------------------------------------------------
    // MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Do Something
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action methods
    
    @IBAction func interactiveTransitionRecognizerAction(sender:UIScreenEdgePanGestureRecognizer) {
        
    }
}

// ===================================================================================================

class SwipeSecondViewController:UIViewController {
    
}

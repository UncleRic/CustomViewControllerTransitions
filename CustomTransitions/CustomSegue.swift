//  CustomSegue.swift
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/3/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class ExternalStoryboardSegue : UIStoryboardSegue {
    
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        
        let myBundle = Bundle.init(identifier: identifier!)
        let externalStoryboard = UIStoryboard(name: identifier!, bundle: myBundle)
        let initialViewController = externalStoryboard.instantiateInitialViewController()
        super.init(identifier: identifier, source: source, destination: initialViewController!)
    }
    override func perform() {
        self.source.present(self.destination, animated: true, completion: nil)
    }
}

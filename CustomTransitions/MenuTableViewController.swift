//
//  MenuTableViewController
//  CustomTransitions
//
//  Created by Frederick C. Lee on 11/2/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

    // -----------------------------------------------------------------------------------------------------
    // MAIN: - Action methods
    @IBAction func unwindToMenuViewController(sender:UIStoryboardSegue) {
        
    }

}


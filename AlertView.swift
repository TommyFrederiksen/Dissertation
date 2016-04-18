//
//  AlertView.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 17/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

class AlertView: UIAlertController {

    var alertController: UIAlertController!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    
    func showYesNoAlert(title: String!, message: String!, style: UIAlertControllerStyle, VC: UIViewController) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let noAction = UIAlertAction(title: "No", style: .Default) { action in
            print("User Pressed Okay")
        }
        
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { action in
            print("User Pressed Okay")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        VC.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showOkayAlert(title: String!, message: String!, style: UIAlertControllerStyle, VC: UIViewController) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okayAction = UIAlertAction(title: "Okay", style: .Default) { action in
            print("User Pressed Okay")
        }
        
        alertController.addAction(okayAction)
        VC.presentViewController(alertController, animated: true, completion: nil)
    }

}

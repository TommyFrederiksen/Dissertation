//
//  LakeInformationVC.swift
//  Figofy
//
//  Created by Tommy on 21/01/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit


class LakeInformationVC: UIViewController {
    
 
    // MARK: IBOutlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var seaImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    // MARK: Variables
    var sea: Sea!
    var payment = MobilePayPayment()
    
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func payHoursTapped(sender: UIButton) {
        var price = Float(200)
        let Id = "3232"
        if sender.tag == 0 {
            price = 130
            
            payment = MobilePayPayment(orderId: Id, productPrice: price)
            
            MobilePayManager.sharedInstance().beginMobilePaymentWithPayment(payment) { error in
                if error.localizedDescription != "" {
                    print(error.localizedDescription)
                }
                
                
            }
            
            
        } else if sender.tag == 1 {
            price = 190
            payment = MobilePayPayment(orderId: Id, productPrice: price)
            
            MobilePayManager.sharedInstance().beginMobilePaymentWithPayment(payment) { error in
                if error.localizedDescription != "" {
                    print(error.localizedDescription)
                }
                
                
            }
            
            
        } else if sender.tag == 2 {
            price = 260
            payment = MobilePayPayment(orderId: Id, productPrice: price)
            
            MobilePayManager.sharedInstance().beginMobilePaymentWithPayment(payment) { error in
                if error.localizedDescription != "" {
                    print(error.localizedDescription)
                }
                
                
            }
            
            
        }
        
        self.performSegueWithIdentifier(SEGUE_PAYMENT, sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // TODO: Time updates etc.
        let tabBarController = segue.destinationViewController as! UITabBarController
        
        if segue.identifier == SEGUE_PAYMENT {
            tabBarController.selectedIndex = 3
            if let profileView = tabBarController.viewControllers![3] as? ClockVC {
                
                
            }
        }
    }
    
}

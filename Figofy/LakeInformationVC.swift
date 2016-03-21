//
//  LakeInformationVC.swift
//  Figofy
//
//  Created by Tommy on 21/01/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0


class LakeInformationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 
    // MARK: IBOutlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var seaImg: UIImageView!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    var sea: FigofySea!
    var payment = MobilePayPayment()
    var hours = [String]()
    var prices = [Int]()
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionView.text = "\(sea.seaDescription!)"
        
        nameLbl.text = sea.seaName
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        if sea.seaPrices?.count > 0 && sea.seaPrices != nil {
            for (key,value) in sea.seaPrices! {
                hours.append(key)
                prices.append(value)
                print("\(key),\(value)")
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        descriptionView.scrollRangeToVisible(NSMakeRange(1, 0))
    }
    
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sea.seaPrices?.count == 0 || sea.seaPrices == nil {
            return 1
        } else {
            return (sea.seaPrices?.count)!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("prices", forIndexPath: indexPath) 
        if sea.seaPrices?.count == 0 || sea.seaPrices == nil {
            
            cell.textLabel?.text = "Ingen priser fundet"
            cell.detailTextLabel?.text = ""
            
            return cell
        } else {
            
            cell.textLabel?.text = "\(hours[indexPath.row])"
            cell.detailTextLabel?.text = "\(prices[indexPath.row]) ,-"
            
            return cell
        }
        
    }
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet weak var pricesBtn: UIButton!
    @IBAction func pricesTapped(sender: UIButton) {
        ActionSheetMultipleStringPicker.showPickerWithTitle("Fisketid", rows: [[3,5,7,24],["timer"]], initialSelection:
            [0,0], doneBlock: {
            picker, values, indexes in
                
                let hours = values[0]
            
                print("Timer: \(hours)")
            
                let alertWithChild = UIAlertController(title: "Har du gæst med?", message: nil, preferredStyle: .Alert)
                let yesAction = UIAlertAction(title: "Ja", style: .Default, handler: { yesAction in
                    ActionSheetMultipleStringPicker.showPickerWithTitle("Fisketid for gæst", rows: [[1,2,3,4,5],["antal"],[3,5,7,24],["timer"]], initialSelection:  [0,0,0,0], doneBlock: { picker, values, indexes in
                        
                        let kids = values[0]
                        let hours = values[2]
                        
                        print("Børn:\(kids), Timer: \(hours)")
                        
                        }, cancelBlock: { ActionMultipleStringCancelBlock in return }, origin: sender)
                    // TODO: NAVIGER VIDERE TIL BETALING
                })
                
                let noAction = UIAlertAction(title: "Nej", style: .Default, handler: { noAction in
                    // TODO: NAVIGER VIDERE TIL BETALING
                    return
                })
            
                alertWithChild.addAction(yesAction)
                alertWithChild.addAction(noAction)
                self.presentViewController(alertWithChild, animated: true, completion: nil)
            
            return
            }, cancelBlock: { ActionMultipleStringCancelBlock in return }, origin: sender)
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

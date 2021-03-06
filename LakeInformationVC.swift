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
    var mobilePayPayment = MobilePayPayment()
    var hours = [String]()
    var prices = [Int]()
    var checkPayment: MPPayment!
    var hourToFutureDate: NSTimeInterval?
    
    // MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.lakeInformation = self
        
        descriptionView.text = "\(sea.seaDescription!)"
        
        nameLbl.text = sea.seaName
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        if sea.seaPrices?.count > 0 || sea.seaPrices != nil {
            let sortedPrices = sea.seaPrices?.sort {$0.1 < $1.1}
            for (key,value) in sortedPrices! {
                hours.append(key)
                prices.append(value)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let totalPrice = prices[indexPath.row]
        let totalHours: String = "\(hours[indexPath.row])"
        let hour = checkHours(totalHours)
        
        // UNIQUE ID FOR TRANSACTION
        //print(NSUUID().UUIDString)
        
        
        let alertWithChild = UIAlertController(title: "Bekræft", message: "Du har valgt \(hour) for \(totalPrice).\n Ønsker du at fortsætte til betaling?", preferredStyle: .ActionSheet)
        
        
        let yesAction = UIAlertAction(title: "Ja", style: .Default, handler: { yesAction in
            let currentTime = NSDate()
            self.hourToFutureDate = Double(hour * 60 * 60)
            
            self.checkPayment = MPPayment(price: totalPrice, startDate: currentTime, endDate: currentTime.dateByAddingTimeInterval(self.hourToFutureDate!))
            
            let orderID = NSUUID().UUIDString
            
            self.mobilePayPayment = MobilePayPayment(orderId: orderID, productPrice: Float(totalPrice))
            
            MobilePayManager.sharedInstance().beginMobilePaymentWithPayment(self.mobilePayPayment, error: { mobilepayError in
                    print(mobilepayError.code)
            })
            
            
        })
        
        
        let noAction = UIAlertAction(title: "Nej", style: .Default, handler: { noAction in
            // TODO: NAVIGER VIDERE TIL BETALING
            return
        })
        
        alertWithChild.addAction(yesAction)
        alertWithChild.addAction(noAction)
        
        self.presentViewController(alertWithChild, animated: true, completion: nil)
        
    }
    
    func updateAndPasInfoToClockVC() {
        self.performSegueWithIdentifier(SEGUE_PAYMENT, sender: self.checkPayment)
    }
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func checkHours(hours: String) -> Int {
        
        var hour: Int = 0
        
        if hours.rangeOfString("1 Timer") != nil {
            hour = 1
        } else if hours.rangeOfString("2 Timer") != nil {
            hour = 2
        } else if hours.rangeOfString("3 Timer") != nil {
            hour = 3
        } else if hours.rangeOfString("4 Timer") != nil {
            hour = 4
        } else if hours.rangeOfString("5 Timer") != nil {
            hour = 5
        } else if hours.rangeOfString("6 Timer") != nil {
            hour = 6
        } else if hours.rangeOfString("7 Timer") != nil {
            hour = 7
        } else if hours.rangeOfString("8 Timer") != nil {
            hour = 8
        } else if hours.rangeOfString("9 Timer") != nil {
            hour = 9
        } else if hours.rangeOfString("10 Timer") != nil {
            hour = 10
        } else if hours.rangeOfString("11 Timer") != nil {
            hour = 11
        } else if hours.rangeOfString("12 Timer") != nil {
            hour = 12
        } else if hours.rangeOfString("Dagskort") != nil {
            hour = 12
        } else if hours.rangeOfString("Døgnkort") != nil {
            hour = 24
        }
        return hour
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // TODO: Time updates etc.
        let tabBarC = segue.destinationViewController as! UITabBarController
        
        if segue.identifier == SEGUE_PAYMENT {
            tabBarC.selectedIndex = 3
            if let clock = tabBarC.viewControllers![3] as? ClockVC {
                if let mppayment = sender as? MPPayment {
                    if mppayment.price > 0 {
                        clock.timeInformation = mppayment
                    }
                }
                
            }
        }
    }
    
}

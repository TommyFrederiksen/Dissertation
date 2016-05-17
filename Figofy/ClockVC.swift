//
//  ClockVC.swift
//  Figofy
//
//  Created by Tommy on 05/02/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

class ClockVC: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var payment: MobilePayPayment?
    let clock = Clock()
    var timeInformation: MPPayment?
    var paymentDict = [DBPaymentRegister]()
    
    var startDate: NSDate?
    var endDate: NSDate?
    
    var timerOn = false
    
    var currentTime: NSTimer!
    var countdownTime: NSTimer?
    
    
    // MARK: View Methods
    override func viewDidLoad(){
        super.viewDidLoad()
        print("VIEWDIDLOAD")
        timeLabel.text = ""
        countdownLabel.text = ""
        //getPaymentFromFirebase()
        
        currentTime = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ClockVC.updateCurrentTime), userInfo: nil, repeats: true)
        
        countdownTime = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ClockVC.updateCountdown), userInfo: nil, repeats: true)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }
    
    
    // MARK: Custom Methods
    func updateCurrentTime() {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
        timeLabel.text = formatter.stringFromDate(clock.currentTime)
    }
    
    func updateCountdown() {
        
        if let validatedEndDate = timeInformation?.endDate  {
            self.endDate = validatedEndDate
            
            if let timeLeft = self.endDate?.timeIntervalSinceNow where timeLeft > 0 {
                countdownLabel.text = timeLeft.time
            }
            
        } else {
            countdownLabel.text = "00:00:00"
        }
        
    }
    func getPaymentFromFirebase(){
        self.paymentDict = []
        DataService.dataService.REF_USERS.childByAppendingPath("facebook:\(DBPaymentRegister.staticPaymentRegister.user)").childByAppendingPath("payment").observeEventType(.ChildAdded, withBlock: { snap in
            print("snapkey: \(snap.key)")
            DataService.dataService.REF_PAYMENT_REGISTER.childByAppendingPath(snap.key).observeEventType(.Value, withBlock: { snapPay in
                print(snapPay)
                if let payDict = snapPay.value as? Dictionary<String, AnyObject>{
                    let payData = DBPaymentRegister(postKey: snap.key, dictionary: payDict)
                    self.paymentDict.append(payData)
                }
            })
        
        })
      
    
    }
    
    
    deinit {
        if let clock = self.currentTime {
            clock.invalidate()
        }
        
        if let timer = self.countdownTime {
            timer.invalidate()
        }
        
    }
    
    
}









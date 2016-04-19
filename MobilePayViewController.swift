//
//  MobilePayViewController.swift
//  Figofy
//
//  Created by Tommy on 21/01/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit
<<<<<<< HEAD
import Firebase
import CoreLocation

class MobilePayViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var amount: TextFieldDesign!
    
    @IBOutlet weak var serverTimeLbl: UILabel!
    var payment: MobilePayPayment?
    var catches = [FigofySea]()
    let locationManager = CLLocationManager()
    
    let currentDate = NSDate()
    let endDate = NSDate.convertFirebaseTimestampToDate(stamp: 1458576108)
    var timer = NSTimer()
    var timerOn = false
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startMonitoringVisits()
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        payBtn.layer.cornerRadius = 8.0
        
        timerOn = !timerOn
        if timerOn {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updateCounter", userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            timerOn = false
        }
        
        
        
    }
    
    func updateCounter() {
        let timeLeft = endDate.timeIntervalSinceNow
        print(timeLeft)
        if timeLeft > 0 {
            serverTimeLbl.text = timeLeft.time
        } else {
            serverTimeLbl.text = "Finished"
            timer.invalidate()
            timerOn = false
        }
    }
    
    func getSeas() {
        
        catches = []
        DataService.dataService.REF_SEAS.observeEventType(.ChildAdded, withBlock: { snapshots in
            
            if let seas = snapshots.value as? Dictionary<String,AnyObject> {
                let key = snapshots.key
                let sea = FigofySea(postKey: key, dictionary: seas)
                print("Name: \(sea.seaName) - Prices: \(sea.seaPrices)")
                self.catches.append(sea)
            }
            
        })
        
    }
    
    
    func getCurrentUsersFish() {
        
    
        DataService.dataService.REF_USERS.childByAppendingPath("facebook:10209515104821303").childByAppendingPath("fish").observeEventType(.Value, withBlock: { snapshot in
            
            self.catches = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    DataService.dataService.REF_FISH.childByAppendingPath(snap.key).observeEventType(.Value, withBlock: { fish in
                        
                        if let fishDict = fish.value as? Dictionary<String, AnyObject> {
                            let key = fish.key
                            let currentFish = Fish(postKey: key, dictionary: fishDict)
                            print("\(currentFish.weight)")
                            self.serverTimeLbl.text = currentFish.bait
                            //self.catches.append(currentFish)
                        }
                        
                    })
                }
            }
            
        })
        
    }
    
    func getFish() {
        
        DataService.dataService.REF_FISH.observeEventType(.Value, withBlock: { snapshot in
            
            
            self.catches = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    print("SNAP: \(snap)")
                    
                    if let fishDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let fish = Fish(postKey: key, dictionary: fishDict)
                        self.serverTimeLbl.text = "\(fish.weight)"
                        //self.catches.append(fish)
                    }
                    
                }
                
            }
            
        })
    }
    
    
    
    func decodeBase64StringToImage(strEncodeData: String?) -> UIImage {
        if let data = strEncodeData {
            let image = NSData(base64EncodedString: data, options: .IgnoreUnknownCharacters)
            return UIImage(data: image!)!
        } else {
            return UIImage()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.location?.coordinate
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { placemarks, error in
            
            if let placemark = placemarks {
                
                print("Addresse : \(placemark[0].name), \(placemark[0].postalCode!) \(placemark[0].subLocality) ,\(placemark[0].country)")
            }
            
            
        })
        
        locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error While updating location " + error.localizedDescription)
    }
    
    
    @IBAction func payBtnPressed(sender: AnyObject) {
        
        if let price = Float(self.amount.text!) where price >= 0 {
            
            let Id = "3232"
            
            if price >= 0 && Id != "" {
                payment = MobilePayPayment(orderId: Id, productPrice: price)
                MobilePayManager.sharedInstance().beginMobilePaymentWithPayment(payment!) { error in
                    if error.localizedDescription != "" {
                        print(error.localizedDescription)
                    }
                    
                    
                }
                
            }
        }
        
        
        //alert.showOkayAlert("MobilePay Initialized", message: "Switching to MobilePay \(orderId: payment.orderId, transactionId: info.transactionId, info.amountWithdrawnFromCard))", style: .Alert, VC: self)
        
    }
}

=======


class MobilePayViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
>>>>>>> origin/master

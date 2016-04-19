//
//  AppDelegate.swift
//  Figofy
//
//  Created by Tommy on 31/12/2015.
//  Copyright © 2015 Tommy. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mppayment: MPPayment?
    var lakeInformation: LakeInformationVC?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        
        //TESTING
        MobilePayManager.sharedInstance().setupWithMerchantId("APPDK0000000000", merchantUrlScheme: "figofy", timeoutSeconds: 30, returnSeconds: 1, captureType: .Capture, country: .Denmark)
        //ACTUAL
//        MobilePayManager.sharedInstance().setupWithMerchantId("APPDK2922783001", merchantUrlScheme: "figofy", timeoutSeconds: 30, returnSeconds: 1, captureType: .Capture, country: .Denmark)
        
        
        //facebook Check for log in
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //activate facebook
        FBSDKAppEvents.activateApp()
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        handleMobilePayPaymentWithUrl(url)
        
        
        let navigationController = application.windows[0].rootViewController! as UIViewController
        
        let activeViewCont = navigationController

        
        print(activeViewCont)
        //When you create a new account with facebook, its going to switch to facebook and handle it
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        
    }
    
    // MARK: MOBILEPAY
    func handleMobilePayPaymentWithUrl(url: NSURL) {
        
        let top: UIViewController?
        if let view = UIApplication.sharedApplication().keyWindow?.rootViewController {
            top = view
        }
        MobilePayManager.sharedInstance().handleMobilePayPaymentWithUrl(url, success: { (mobilePaySuccess: MobilePaySuccessfulPayment?) -> Void in
            
            let orderId = mobilePaySuccess!.orderId
            let transactionId = mobilePaySuccess!.transactionId
            let amountWithdrawnFromCard = "\(mobilePaySuccess!.amountWithdrawnFromCard)"
            
            DBPaymentRegister.staticPaymentRegister.orderId = orderId
            DBPaymentRegister.staticPaymentRegister.transactionId = transactionId
            DBPaymentRegister.staticPaymentRegister.amount = Int(amountWithdrawnFromCard)!
            
            let newPaymentRegister: Dictionary<String, AnyObject> = [
                "time_creted" : FirebaseServerValue.timestamp(),
                "amount" : DBPaymentRegister.staticPaymentRegister.amount,
                "seas" : DBPaymentRegister.staticPaymentRegister.seas,
                "user" : DBPaymentRegister.staticPaymentRegister.user,
                "bought_time_start" : DBPaymentRegister.staticPaymentRegister.boughtTimeStart,
                "bought_time_end" : DBPaymentRegister.staticPaymentRegister.boughtTimeEnd,
                "order_id" : DBPaymentRegister.staticPaymentRegister.orderId,
                "transaction_id" : DBPaymentRegister.staticPaymentRegister.transactionId
            ]
            
            DataService.dataService.createFirebasePaymentRegister(newPaymentRegister)
            
            self.lakeInformation?.updateAndPasInfoToClockVC()
            
            
            }, error: { error in
                // Listed from 1-12
                print(error.code)
                // Unknown error occurred
                if error.code == MobilePayErrorCode.Unknown.rawValue {
                    print(error.description)
                }
                // Invalid parameters sent to MobilePay app
                else if error.code == MobilePayErrorCode.InvalidParameters.rawValue {
                    print(error.description)
                }
                // VerifyMerchant request failed - validation af merchant failed.
                else if error.code == 2 {
                    print(error.description)
                }
                // MobilePay app is out of date and should be updated
                else if error.code == MobilePayErrorCode.UpdateApp.rawValue {
                    // TODO: NOTFIY USER #3
                    AlertView().showOkayAlert("MobilePay Outdated", message: "Please update your MobilePay Application", style: .Alert, VC: self.lakeInformation!)
                    print(error.description)
                }
                // Merchant is not valid
                else if error.code == MobilePayErrorCode.MerchantNotValid.rawValue {
                    print(error.description)
                }
                // Hmac parameter is not valid
                else if error.code == MobilePayErrorCode.HMACNotValid.rawValue {
                    print(error.description)
                }
                // MobilePay timeout, the purchase took more than 5 minutes
                else if error.code == MobilePayErrorCode.TimeOut.rawValue {
                    // TODO: NOTFIY USER #6
                    AlertView().showOkayAlert("MobilePay TimeOut", message: "The purchase took more than 5 minutes", style: .Alert, VC: self.lakeInformation!)
                    print(error.description)
                }
                // MobilePay amount limits exceeded. Open MobilePay 'Beløbsgrænser' to see your status.
                else if error.code == MobilePayErrorCode.LimitsExceeded.rawValue {
                    // TODO: NOTFIY USER #7
                    
                    //AlertView().showOkayAlert("Limit Exceeded", message: "Open MobilePay 'Beløbsgrænser' to see your status.", style: .Alert, VC: currentVC!)
                    print(error.description)
                }
                // Timeout set in merchant app exceeded
                else if error.code == MobilePayErrorCode.MerchantTimeout.rawValue {
                    // TODO: NOTFIY USER #8
                    AlertView().showOkayAlert("MobilePay TimeOut", message: "Lost connection to server, please try again later", style: .Alert, VC: self.lakeInformation!)
                    print(error.description)
                }
                // Invalid signature
                else if error.code == MobilePayErrorCode.InvalidSignature.rawValue {
                    print(error.description)
                }
                // MobilePay SDK version is outdated
                else if error.code == MobilePayErrorCode.SDKIsOutdated.rawValue {
                    print(error.description)
                }
                // The given OrderId is already used. An OrderId has to be unique.
                else if error.code == MobilePayErrorCode.OrderIdAlreadyUsed.rawValue {
                    print(error.description)
                }
                // The payment was rejected because the user is chosen for fraud validation.
                else if error.code == MobilePayErrorCode.PaymentRejectedFraud.rawValue {
                    print(error.description)
                }
                
            }) { paymentCancelled in
                // TODO: CANCELATION HANDLING
                print("MobilePay blev annulleret \(paymentCancelled?.orderId) af bruger")
                AlertView().showOkayAlert("Betaling Annulleret", message: "MobilePay blev annulleret af bruger med Id \(paymentCancelled!.orderId)", style: .Alert, VC: self.lakeInformation!)
        }
        
    }

    
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "dk.salameh.Recipez" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Figofy", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
}


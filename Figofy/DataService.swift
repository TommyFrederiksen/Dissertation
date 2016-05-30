//
//  DataService.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 22/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://figofydatabase.firebaseio.com"

class DataService {
    static let dataService = DataService()
    
    // MARK: Variables
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_SEAS = Firebase(url: "\(URL_BASE)/seas")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    private var _REF_FISH = Firebase(url: "\(URL_BASE)/fish")
    private var _REF_PAYMENT_REGISTER = Firebase(url: "\(URL_BASE)/payment")
    private var _CURRENT_TIMESTAMP = FirebaseServerValue.timestamp()
    
    // MARK: Properties
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_SEAS: Firebase {
        return _REF_SEAS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_PAYMENT_REGISTER: Firebase{
        return _REF_PAYMENT_REGISTER
    }
    
    var REF_USER_CURRENT: Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        //same as doing /users after the URL_BASE
        let user = Firebase(url: "\(URL_BASE)").childByAppendingPath("users").childByAppendingPath(uid)
        return user
    }
    
    var REF_FISH: Firebase {
        return _REF_FISH
    }
    
    
    
    // MARK: Post Methods
    func createFirebaseUser(uid: String, var user: Dictionary<String, AnyObject>) {
        //'/users/33asdf12f34' if it doesnt exist, it will create it. Or if it does it will update it
        user.updateValue(FirebaseServerValue.timestamp(), forKey: "member_since")
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
    func createFish(fish: Dictionary<String, AnyObject>) {
        let postRef = REF_FISH.childByAutoId()
        postRef.setValue(fish)
        
        let postId = postRef.key
        let fishRef = REF_USER_CURRENT.childByAppendingPath("fish").childByAppendingPath(postId)
        
        
        fishRef.observeEventType(.Value, withBlock: { snapshot in
            
            if let _ = snapshot.value as? NSNull {
                fishRef.setValue(true)
            }
            
        })
        
    }
    func createFirebasePaymentRegister(register: Dictionary<String, AnyObject>){
        let postRef = REF_PAYMENT_REGISTER.childByAutoId()
        postRef.setValue(register)
        
        //__________________________________posting to Seas___________________________
        let postId = postRef.key
        let REFSEA = REF_SEAS.childByAppendingPath(DBPaymentRegister.staticPaymentRegister.seas)
        let paymentRefSea = REFSEA.childByAppendingPath("payment").childByAppendingPath(postId)
        
        paymentRefSea.observeEventType(.Value, withBlock: { snapshot in
            if let _ = snapshot.value as? NSNull {
                
                paymentRefSea.setValue(true)
            }
        })
        //__________________________________posting to User___________________________
        
        let REFUSER = REF_USERS.childByAppendingPath("facebook:\(DBPaymentRegister.staticPaymentRegister.user)")
        let paymentRefUser = REFUSER.childByAppendingPath("payment").childByAppendingPath(postId)
        
        paymentRefUser.observeEventType(.Value, withBlock: { snapshot in
            if let _ = snapshot.value as? NSNull {
                
                paymentRefUser.setValue(true)
            }
            
        })
        
    }
}
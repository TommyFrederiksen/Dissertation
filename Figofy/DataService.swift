//
//  DataService.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 22/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://figofydev.firebaseio.com"

class DataService {
    static let dataService = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_SEAS = Firebase(url: "\(URL_BASE)/seas")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    private var _REF_FISH = Firebase(url: "\(URL_BASE)/fish")
    private var _REF_CATCH = Firebase(url: "\(URL_BASE)/catch")
    private var _CURRENT_TIMESTAMP = Firebase()
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_SEAS: Firebase {
        return _REF_SEAS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_FISH: Firebase {
        return _REF_FISH
    }
    
    var REF_CATCH: Firebase {
        return _REF_CATCH
    }
    
    
    func createFirebaseUser(uid: String, user: Dictionary<String, AnyObject>) {
        //'/users/33asdf12f34' if it doesnt exist, it will create it. Or if it does it will update it
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
}
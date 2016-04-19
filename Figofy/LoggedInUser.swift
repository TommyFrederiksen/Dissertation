//
//  LoggedInUser.swift
//  Figofy
//
//  Created by Tommy on 14/03/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//
import UIKit
import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class LoggedInUser {
    
    var _id:String
    var _firstName: String
    
    init(id: String?, firstName: String?)
    {
        _id = id!
        _firstName = firstName!
    }
    
    private static var CLoggedInUser: LoggedInUser?
    
    static func CurrentLoggedInUser(Id: String,FirstName: String) -> LoggedInUser{
        if CLoggedInUser == nil{
            CLoggedInUser = LoggedInUser(id: Id,firstName: FirstName)
        }
        return CLoggedInUser!
    }
    static func CurrentLoggedInUser() -> LoggedInUser{
        return CLoggedInUser!
    }
    
    
}

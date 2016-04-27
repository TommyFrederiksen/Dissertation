//
//  FigofyUser.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 24/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import Firebase

enum Gender: String {
    case Female = "female"
    case Male = "Male"
}

class FigofyUser {
    
    
    // MARK: Variables
    private var _userPostKey: String!
    private var _facebookId: String!
    private var _firstName: String!
    private var _middleName: String?
    private var _lastName: String!
    private var _email: String!
    private var _gender: String!
    private var _birthday: String!//TODO
    private var _dateCreated: NSTimeInterval!
    
    var facebookId: String {
        return _facebookId
    }
    
    var userFirstName: String {
        return _firstName
    }
    
    var userMiddleName: String? {
        return _middleName
    }
    
    var userLastName: String {
        return _lastName
    }
    
    var email: String {
        return _email
    }
    
    var userGender: String {
        return _gender
    }
    
    var userBirthday: String {
        return _birthday
    }
    
    var userMemberLength: NSDate {
        return NSDate.convertFirebaseTimestampToDate(stamp: _dateCreated)
    }
    
    
    init(facebookId: String, firstname: String, lastname: String, gender: String, birthday: String) {
        self._facebookId = facebookId
        self._firstName = firstname
        self._lastName = lastname
        self._gender = gender
        self._birthday = birthday
    }
    
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._userPostKey = postKey
        
        if let id = dictionary["id"] as? String {
            print("facebookId: \(id)")
            self._facebookId = id
        }
        if let fName = dictionary["first_name"] as? String {
            print("firstName: \(fName)")
            self._firstName = fName
        }
        
        if let fLast = dictionary["last_name"] as? String {
            print("lastName: \(fLast)")
            self._lastName = fLast
        }
        
        if let email = dictionary["email"] as? String {
            print("Email: \(email)")
            self._email = email
        }
        
        if let birthday = dictionary["birthday"] as? String {
            print("BirthDay: \(birthday)")
            self._birthday = birthday
        }
        
        if let gender = dictionary["gender"] as? String {
            print("Gender: \(gender)")
            self._gender = gender
        }
        
        if let location = dictionary["location"] as? Dictionary<String, AnyObject> {
            print("Location: \(location)")
        }
        
        if let memberSince = dictionary["member_since"] as? NSTimeInterval {
            print("Member Since: \(memberSince)")
            self._dateCreated = memberSince
        }
        
    }
    
    // MARK: Custom Methods
    
    
    
    
}
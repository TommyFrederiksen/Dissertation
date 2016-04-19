//
//  ProfileSingleton.swift
//  Figofy
//
//  Created by Tommy on 02/02/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation

class ProfileSingleton {
    static let sharedInstance = ProfileSingleton(name: "",address: "")
    var _name = ""
    var _address = ""
    
    private init(var name: String, var address: String)
    {
        name = _name
        address = _address
        
    }
}

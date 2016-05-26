//
//  Friend.swift
//  Figofy
//
//  Created by Tommy on 24/05/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
class Friend {
    
    var _name: String!
    var _id: String!
    var _image: String!
    
    var name: String {
        return _name
    }
    var id:String {
        return _id
    }
    var image: String{
        return _image
    }
    
    init(name: String, image: String){
        _name = name
    
        _image = image
        
    }
}

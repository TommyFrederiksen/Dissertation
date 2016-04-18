//
//  Event.swift
//  Figofy
//
//  Created by Tommy on 04/02/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import UIKit


class Event
{
    var _name: String!
    var _description: String!
    var _dateTime: String!
    var _photo: UIImage!
    
    init(name: String, description: String, dateTime: String, photo: UIImage)
    {
        _name = name
        _description = description
        _dateTime = dateTime
        _photo = photo
        
    }
    
}
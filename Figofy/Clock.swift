//
//  Clock.swift
//  Figofy
//
//  Created by Tommy on 05/02/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import UIKit



class Clock {
    
    var hours: Int = 0
    
    var currentTime: NSDate {
        
        return NSDate()
    }
    var currentTimeFormatter: NSDateFormatter {
        return NSDateFormatter()
    }
    func setLocalTimeDenmark(time: NSDate) -> String{
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(name: "Europe/Copenhagen")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        return formatter.stringFromDate(time)
        
    }
   
    
    
}


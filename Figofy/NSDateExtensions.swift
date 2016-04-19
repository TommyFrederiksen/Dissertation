//
//  NSDateExtensions.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 11/03/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func convertFirebaseTimestampToDate(stamp timestamp: NSTimeInterval) -> NSDate {
        return NSDate(timeIntervalSince1970: timestamp/1000)
    }
    
    class func convertToString(time dateTime: NSDate, style: NSDateFormatterStyle) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = style
        return formatter.stringFromDate(dateTime)
    }
    
    var zeroSecond : NSDate {
        return NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(hour, minute: minute, second: 0, ofDate: self, options: [])!
    }
    var nextRoundMinute : NSDate {
        return NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateBySettingHour(NSDate().hour, minute: NSDate().minute+1, second: 0, ofDate: NSDate(), options: [])!
    }
    
    var minute: Int {
        return NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.component(NSCalendarUnit.Minute, fromDate: self)
    }
    var hour: Int {
        return NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.component(NSCalendarUnit.Hour, fromDate: self)
        
    }
    
}
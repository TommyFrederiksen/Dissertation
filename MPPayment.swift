//
//  MPPayment.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 22/03/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation


class MPPayment {
    
    private var _price: Int!
    private var _startDate: NSDate!
    private var _endDate: NSDate?
    
    var price: Int {
        return _price
    }
    
    var startDate: NSDate {
        return _startDate
    }
    
    var endDate: NSDate? {
        return _endDate
    }
    
    
    init(price: Int, startDate: NSDate, endDate: NSDate?) {
        self._price = price
        self._startDate = startDate
        self._endDate = endDate
    }
    
}
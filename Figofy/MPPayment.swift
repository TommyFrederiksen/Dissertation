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
    private var _startDate: String!
    private var _endDate: NSDate?
    
    var price: Int {
        get{
            return _price}
        set{
            _price = newValue
        }
    }
    
    var startDate: String{
        get{
            return _startDate
        }set{
            _startDate = newValue
        }
    }
    
    var endDate: NSDate? {
        get{
        return _endDate
        }set{
            _endDate = newValue
        }
    }
    
    init(){}
//    init(price: Int, startDate: NSDate, endDate: NSDate?) {
//        self._price = price
//        self._startDate = startDate
//        self._endDate = endDate
//    }
    
}
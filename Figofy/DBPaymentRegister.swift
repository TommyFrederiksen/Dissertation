//
//  DBPaymentRegister.swift
//  Figofy
//
//  Created by Janus Ringling on 19/04/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation

class DBPaymentRegister{
    
    static var staticPaymentRegister = DBPaymentRegister()
    
    private var _paymentPostkey: String!
    private var _amount: Int!
    private var _seas: String!
    private var _user: String!
    private var _boughtTimeStart: String!
    private var _boughtTimeEnd: NSDate!
    private var _orderId: String!
    private var _transaktionId: String!
    private var _name: String!
    private var _product: String!
    private var _hours: Int!
    
    var paymentPostKey: String {
        get{
            return _paymentPostkey!
        }
        set{
            _paymentPostkey = newValue
        }
        
    }
    
    var amount: Int {
        get{
            return _amount!
        }
        set{
            _amount = newValue
        }
        
    }
    
    var seas: String {
        get{
            return _seas!
        }
        set{
            _seas = newValue
        }
        
    }
    
    var user: String {
        get{
            return _user!
        }
        set{
            _user = newValue
        }
        
    }
    
    var boughtTimeStart: String {
        get{
            return _boughtTimeStart!
        }
        set{
            _boughtTimeStart = newValue
        }
        
    }
    var boughtTimeEnd: NSDate {
        get{
            return _boughtTimeEnd
        }
        set{
            _boughtTimeEnd = newValue
        }
        
    }
    
    var orderId: String {
        get{
            return _orderId!
        }
        set{
            _orderId = newValue
        }
        
    }
    
    var transactionId: String {
        get{
            return _transaktionId!
        }
        set{
            _transaktionId = newValue
        }
        
    }
    var name: String {
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    var product: String {
        get{
            return _product
        }
        set{
            _product = newValue
        }
    }
    var hours: Int {
        get{
            return _hours
        }
        set{
            _hours = newValue
        }
    }
    
    init (){
        
    }
    
    init (postKey: String, dictionary: Dictionary<String, AnyObject>){
        self._paymentPostkey = postKey
        
        if let amount = dictionary["amount"] as? Int{
            self._amount = amount
        }
        if let seas = dictionary["seas"] as? String{
            self._seas = seas
        }
        if let user = dictionary["user"] as? String{
            self._user = user
        }
        if let boughtTimeStart = dictionary["bought_time_start"] as? String{
            self._boughtTimeStart = boughtTimeStart
        }
        if let hours = dictionary["hours"] as? Int{
            self._hours = hours
        }
        if let orderId = dictionary["order_id"] as? String{
            self._orderId = orderId
        }
        if let transactionId = dictionary["transaction_id"] as? String{
            self._transaktionId = transactionId
        }

        if let name = dictionary["name"] as? String {
            self._name = name
        }
        if let product = dictionary["product"] as? String {
            self._product = product
        }
        
        
        
    }

    
}

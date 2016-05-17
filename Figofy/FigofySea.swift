//
//  FigofySea.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 24/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import CoreLocation

class FigofySea {
    
    static var staticMerchantId = ""
    
    private var _seaId: String!
    private var _seaPostKey: String!
    private var _seaName: String!
    private var _seaDescription: String?
    private var _seaEmail: String?
    private var _seaTlf: Int?
    private var _seaWebsite: String?
    private var _isFigofySea: Bool!
    private var _seaStreetName: String!
    private var _seaStreetNumber: Int!
    private var _seaZipCode: Int!
    private var _seaCity: String!
    private var _seaLatitude: CLLocationDegrees?
    private var _seaLongitude: CLLocationDegrees?
    private var _seaPrices: Dictionary<String,Int>?
    private var _seaCoverImgUrl: String?
    private var _seaProfileImgUrl: String?
    private var _merchantId: String!
    
    var seaId: String {
        return _seaId
    }
    
    var seaName: String {
        return _seaName
    }
    
    var seaDescription: String? {
        return _seaDescription
    }
    
    var seaEmail: String? {
        return _seaEmail
    }
    
    var seaWebsite: String? {
        return _seaWebsite
    }
    
    var isFigofySea: Bool {
        return _isFigofySea
    }
    
    var seaTlf: Int? {
        return _seaTlf
    }
    
    var fullAddress: String? {
        return "\(_seaStreetName) \(_seaStreetNumber),\(_seaZipCode) \(_seaCity)"
    }
    
    var seaStreetName: String {
        return _seaStreetName
    }
    
    var seaStreetNumber: Int {
        return _seaStreetNumber
    }
    
    var seaZipCode: Int {
        return _seaZipCode
    }
    
    var seaCity: String {
        return _seaCity
    }
    
    var seaLongitude: CLLocationDegrees? {
        return _seaLongitude
    }
    
    var seaLatitude: CLLocationDegrees? {
        return _seaLatitude
    }
    
    var seaPrices: Dictionary<String, Int>? {
        return _seaPrices
    }
    var seaCoverImgUrl: String? {
        return _seaCoverImgUrl
    }
    
    var seaProfileImgUrl: String? {
        return _seaProfileImgUrl
    }
    
    var merchantId: String {
        return _merchantId
    }
    
    init(name: String, streetName: String, streetNumber: Int, zipCode: Int, city: String) {
        self._seaName = name
        self._seaStreetName = streetName
        self._seaStreetNumber = streetNumber
        self._seaZipCode = zipCode
        self._seaCity = city
    }
    
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._seaPostKey = postKey
        
        if let id = dictionary["id"] as? String {
            self._seaId = id
        }
        
        if let name = dictionary["name"] as? String {
            self._seaName = name
        }
        
        if let email = dictionary["email"] as? String {
            self._seaEmail = email
        }
        
        if let website = dictionary["website"] as? String {
            self._seaWebsite = website
        }
        
        if let tlf = dictionary["telefon"] as? Int {
            self._seaTlf = tlf
        }
        
        if let isit = dictionary["is_figofy_sea"] as? Bool {
            self._isFigofySea = isit
        }
        
        if let desc = dictionary["description"] as? String {
            self._seaDescription = desc
        }
        if let merc = dictionary["merchant_id"] as? String{
            self._merchantId = merc
        }
        
        if let address = dictionary["address"] as? Dictionary<String, AnyObject> {
            if let streetName = address["street"] as? String {
                self._seaStreetName = streetName
            }
            if let streetNumber = address["number"] as? Int {
                self._seaStreetNumber = streetNumber
            }
            if let zipCode = address["zipCode"] as? Int {
                self._seaZipCode = zipCode
            }
            if let city = address["city"] as? String {
                self._seaCity = city
            }
            if let lat = address["latitude"] as? CLLocationDegrees {
                self._seaLatitude = lat
            }
            if let lon = address["longitude"] as? CLLocationDegrees {
                self._seaLongitude = lon
            }
        }
        
        if let prices = dictionary["prices"] as? Dictionary<String, Int> {
            if prices.count > 0 {
                self._seaPrices = prices
            }
        }
    }
    
    
}
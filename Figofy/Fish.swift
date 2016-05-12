//
//  Fish.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 02/03/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

class Fish {
    
    static var staticFish = Fish()
    
    enum Species: Int, CustomStringConvertible {
        case Laks = 0, Ørred,Guldørred,Havørred,Regnbueørred,Bækørred, GuldLaks, Torsk, Hvilling, Kuller, Lange,Stør,Aborre,Gede,Skalle
        
        static var count: Int {return Lange.rawValue + 1}
        
        static var array = [Laks, Ørred,Guldørred,Havørred,Regnbueørred,Bækørred, GuldLaks, Torsk, Hvilling, Kuller, Lange,Stør,Aborre,Gede,Skalle]
        
        var description: String {
            switch self {
            case Laks: return "Laks"
            case Guldørred: return "Guldørred"
            case Ørred: return "Ørred"
            case GuldLaks: return "GuldLaks"
            case Torsk: return "Torsk"
            case Hvilling: return "Hvilling"
            case Kuller: return "Kuller"
            case Lange: return "Lange"
            case Havørred: return "Havørred"
            case Regnbueørred: return "Regnbueørred"
            case Bækørred: return "Bækørred"
            case Stør: return "Stør"
            case Aborre: return "Aborre"
            case Gede: return "Gede"
            case Skalle: return "Skalle"
            }
        }

        
        var value: Int {
            switch self {
            case .Laks: return 0
            case .Ørred: return 1
            case .GuldLaks: return 2
            case .Torsk: return 3
            case .Hvilling: return 4
            case .Kuller: return 5
            case .Lange: return 6
            case .Guldørred: return 7
            case .Havørred: return 8
            case .Regnbueørred: return 9
            case .Bækørred: return 10
            case .Stør: return 11
            case .Aborre: return 12
            case .Gede: return 13
            case .Skalle: return 14
            }
            
        }
        
        init?(value: Int) {
            switch value {
            case 0 : self = .Laks
            case 1 : self = .Ørred
            case 2 : self = .GuldLaks
            case 3 : self = .Torsk
            case 4 : self = .Hvilling
            case 5 : self = .Kuller
            case 6 : self = .Lange
            case 7 : self = .Guldørred
            case 8 : self = .Havørred
            case 9 : self = .Regnbueørred
            case 10 : self = .Bækørred
            case 11 : self = .Stør
            case 12 : self = .Aborre
            case 13 : self = .Gede
            case 14 : self = .Skalle
            default : return nil
            }
        }
    }
    
    private var _fishPostKey: String!
    private var _imageStr: String?
    private var _length: Float!
    private var _weight: Double!
    private var _species: String!
    private var _bait: String!
    private var _method: String!
    private var _note: String!
    private var _timeCatched: Double!
    private var _timeCreatedNSTimeInterval: NSTimeInterval!
    private var _latitude: CLLocationDegrees?
    private var _longitude: CLLocationDegrees?
    private var _fishRef: Firebase!
    private var _cougntBy: String?
    
    var imageStr: String? {
        return _imageStr
    }
    
    var length: Float {
        return _length
    }
    
    var weight: Double {
        return _weight
    }
    
    var species: String {
        return _species
    }
    
    var bait: String {
        return _bait
    }
    
    var method: String {
        return _method
    }
    
    var note: String {
        return _note
    }
    
    var timeCatched: Double {
        return _timeCatched
    }
    var timeCatchedNSTimeInterval: NSDate {
        return NSDate.convertFirebaseTimestampToDate(stamp: _timeCreatedNSTimeInterval)
    }
    
    var latitude: CLLocationDegrees? {
        return _latitude
    }
    
    var longitude: CLLocationDegrees? {
        return _longitude
    }
    
    var fishPostKey: String {
        return _fishPostKey
    }
    var coughtBy: String {
        get{
            return _cougntBy!
        }
        set{
          _cougntBy = newValue
        }
        
    }
    init(){
    }
    
    init(postKey: String) {
        self._fishPostKey = postKey
    }
    
    init(imageStr: String, length: Float, weight: Double, species: String) {
        self._imageStr = imageStr
        self._length = length
        self._weight = weight
        self._species = species
    }
    
    
    init(postKey: String, dictionary: Dictionary<String,AnyObject>) {
        self._fishPostKey = postKey
        
        if let imgStr = dictionary["imageStr"] as? String {
            self._imageStr = imgStr
        }
        
        if let length = dictionary["length"] as? Float {
            self._length = length
        }
        
        if let kind = dictionary["species"] as? String {
            self._species = kind
        }
        
        if let weight = dictionary["weight"] as? Double {
            self._weight = weight
        }
        
        if let catched = dictionary["catched"] as? Dictionary<String, AnyObject> {
            
            if let bait = catched["bait"] as? String {
                self._bait = bait
            }
            
            if let method = catched["method"] as? String {
                self._method = method
            }
            
            if let note = catched["note"] as? String {
                self._note = note
            }
            
            if let time = catched["time_catched"] as? Double {
                self._timeCatched = time
            }
            if let time_Catched = catched["time_catched"] as? NSTimeInterval{
                self._timeCreatedNSTimeInterval = time_Catched
            }
            
            if let latitude = catched["latitude"] as? CLLocationDegrees {
                self._latitude = latitude
            }
            
            if let longitude = catched["longitude"] as? CLLocationDegrees {
                self._longitude = longitude
            }
            
        }
    }
    
}
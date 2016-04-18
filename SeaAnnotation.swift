//
//  SeaAnnotation.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 01/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit
import MapKit

class SeaAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    
    
}

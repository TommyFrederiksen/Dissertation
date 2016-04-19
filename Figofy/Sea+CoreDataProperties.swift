//
//  Sea+CoreDataProperties.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 02/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Sea {

    @NSManaged var address: String?
    @NSManaged var city: String?
    @NSManaged var name: String?
    @NSManaged var zipCode: String?
    @NSManaged var image: NSData?

}

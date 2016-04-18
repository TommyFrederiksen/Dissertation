//
//  NSTimeIntervalExtensions.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 22/03/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation

extension NSTimeInterval {
    var time:String {
        return String(format:"%02dh %02dm %02ds",Int((self/3600.0)%24), Int((self/60.0)%60), Int((self)%60 ))
    }
}
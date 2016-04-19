//
//  FishCatch.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 02/03/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation

class FishCatch {
    
    private var _fishCatchPostKey: String!
    private var _fishId: String!
    private var _bait: String!
    private var _method: String!
    private var _note: String!
    
    
    
    init(fishId: String, bait: String, method: String, note: String) {
        self._fishId = fishId
        self._bait = bait
        self._method = method
        self._note = note
    }
    
    init(postKey: String, fishId: String, bait: String, method: String, note: String) {
        // TODO: Post to firebase
    }
    
}
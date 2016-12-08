//
//  CycleTest.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/7/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
class CycleTest : NSObject
{
    var uid: String
    var date : Date
    var ammonia_level : Double
    var nitrate_level : Double
    var nitrite_level : Double
    var notes: String
    
    init(uid: String, date: Date, ammonia_level : Double, nitrate_level : Double, nitrite_level : Double, notes : String)
    {
        self.uid = uid
        self.date = date
        self.ammonia_level = ammonia_level
        self.nitrate_level = nitrate_level
        self.nitrite_level = nitrite_level
        self.notes = notes
    }
    
    convenience override init()
    {
        self.init(uid: "", date: Date.init(), ammonia_level: 0, nitrate_level: 0, nitrite_level: 0, notes: "")
    }
}

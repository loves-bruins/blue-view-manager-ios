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
    var date : String
    var ammonia : Double
    var nitrate : Double
    var nitrite : Double
    var notes: String
    
    init(uid: String, date: String, ammonia : Double, nitrate : Double, nitrite : Double, notes : String)
    {
        self.uid = uid
        self.date = date
        self.ammonia = ammonia
        self.nitrate = nitrate
        self.nitrite = nitrite
        self.notes = notes
    }
    
    convenience override init()
    {
        self.init(uid: "", date: "", ammonia: 0, nitrate: 0, nitrite: 0, notes: "")
    }
}

//
//  Service.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/5/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class Service : NSObject {
    var uid: String
    var title: String
    var price: Double
    var date: String
    var notes: String
    
    
    init(uid: String, title: String, price: Double, date: String, notes: String){
        self.uid = uid
        self.title = title
        self.price = price
        self.date = date
        self.notes = notes
    }
    
    convenience override init() {
        self.init(uid: "", title: "", price: 0.00, date: "", notes: "")
    }
}

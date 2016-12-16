//
//  Service.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/5/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class Service : NSObject {
    var id: String
    var price: Double
    var title: String

    var uid: String
    var date: String
    var notes: String
    
    
    init(id: String, uid: String, title: String, price: Double, date: String, notes: String){
        self.id = id
        self.uid = uid
        self.title = title
        self.price = price
        self.date = date
        self.notes = notes
    }
    
    convenience override init() {
        self.init(id: "", uid: "", title: "", price: 0.00, date: "", notes: "")
    }
}

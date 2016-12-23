//
//  Service.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/5/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class Service : NSObject {
    var service_id: String
    var price: Double
    var title: String

    var uid: String
    var date: Int64
    var notes: String
    
    
    init(service_id: String, uid: String, title: String, price: Double, date: Int64, notes: String){
        self.service_id = service_id
        self.uid = uid
        self.title = title
        self.price = price
        self.date = date
        self.notes = notes
    }
    
    convenience override init() {
        self.init(service_id: "", uid: "", title: "", price: 0.00, date: 0, notes: "")
    }
}

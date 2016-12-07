//
//  Purchase.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/5/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class Purchase : NSObject {
    var uid: String
    var customer: String
    var date: NSDate
    var quantity: Int32
    var itemDescription: String
    
    init(uid: String, customer: String, date: NSDate, quantity: Int32, itemDescription: String){
        self.uid = uid
        self.customer = customer
        self.date = date
        self.quantity = quantity
        self.itemDescription = itemDescription
    }
    
    convenience override init() {
        self.init(uid: "", customer: "", date: NSDate.init(timeIntervalSinceNow: 0), quantity: 0, itemDescription: "")
    }
    
}

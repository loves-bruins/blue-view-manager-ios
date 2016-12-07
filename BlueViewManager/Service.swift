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
    var customer: String
    var date: NSDate
    var serviceDescription: String
    
    
    init(uid: String, customer: String, date: NSDate, serviceDescription: String){
        self.uid = uid
        self.customer = customer
        self.date = date
        self.serviceDescription = serviceDescription
    }
    
    convenience override init() {
        self.init(uid: "", customer: "", date: NSDate.init(timeIntervalSinceNow: 0), serviceDescription: "")
    }
}

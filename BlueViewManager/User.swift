//
//  User.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/5/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class User: NSObject {
    var userName: String
    var email: String
    
    init(userName: String, email: String)
    {
        self.userName = userName
        self.email = email
    }
    
    convenience override init() {
        self.init(userName: "", email: "")
    }
}

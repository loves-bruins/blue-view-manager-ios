//
//  User.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/5/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class User: NSObject {
    var uid: String
    var userName: String
    
    init(uid: String, userName: String)
    {
        self.uid = uid
        self.userName = userName
    }
    
    convenience override init() {
        self.init(uid: "", userName: "")
    }
}

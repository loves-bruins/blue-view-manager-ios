//
//  Date+millisecondsSince1970.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 1/4/17.
//  Copyright © 2017 Loren Rogers. All rights reserved.
//

import UIKit

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}


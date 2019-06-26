//
//  TimestampUtils.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/25/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import Foundation

import Foundation

class TimestampUtils: NSObject {
    
    class func getStringForTimestamp(timestamp: Double) -> String {
        let currentTime = NSDate().timeIntervalSince1970
        let diffInSeconds = (currentTime - timestamp)
        if (diffInSeconds < 60) {
            return "<1M"
        } else if (diffInSeconds < 3600) {
            let numberOfMinutes = Int(floor(round(diffInSeconds / 60)))
            return "\(numberOfMinutes)M"
        } else if (diffInSeconds < 86400) {
            let numberOfHours = Int(floor(round(diffInSeconds / 3600)))
            return "\(numberOfHours)H"
        } else {
            let numberOfDays = Int(floor(round(diffInSeconds / 86400)))
            return "\(numberOfDays)D"
        }
    }
    
}

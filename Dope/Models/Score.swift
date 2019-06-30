//
//  Score.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/28/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import Foundation
import SwiftyJSON

class Score {
    var name: String!
    var value: Int!
    var timestamp: Double!
    
    init(json: [String: JSON]) {
        self.name = json["name"]?.stringValue
        self.value = json["value"]?.intValue
        self.timestamp = json["timestamp"]?.doubleValue
    }
}

//
//  Choice.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/28/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import Foundation
import SwiftyJSON

class Choice {
    var id: String!
    var text: String!
    
    init(json: JSON) {
        let choiceMap = json.dictionaryValue
        self.id = choiceMap["id"]?.stringValue
        self.text = choiceMap["text"]?.stringValue
    }
}

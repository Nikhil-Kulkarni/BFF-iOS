//
//  Models.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/4/19.
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

class Question {
    var id: String!
    var text: String!
    var choices: [Choice] = [Choice]()

    init(json: [String: JSON]) {
        self.id = json["id"]?.stringValue
        self.text = json["text"]?.stringValue
        
        let choicesJson = json["choices"]?.arrayValue
        guard let choicesList = choicesJson else {
            return
        }
        
        for choiceJson in choicesList {
            let choice = Choice(json: choiceJson)
            self.choices.append(choice)
        }
    }
}

class Score {
    var name: String!
    var value: Int!
    var timestamp: Double!
    
    init(json: [String: JSON]) {
        self.name = json["name"]?.stringValue
        self.value = json["name"]?.intValue
        self.timestamp = json["timestamp"]?.doubleValue
    }
}

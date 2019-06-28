//
//  Question.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/28/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import Foundation
import SwiftyJSON

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

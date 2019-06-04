//
//  Models.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/4/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import Foundation

class Choice {
    var id: String!
    var text: String!
    
    init(map: [String: String]) {
        self.id = map["id"]
        self.text = map["text"]
    }
}

//class Question {
//    var id: String!
//    var text: String!
//    var choice: Choice!
//
//    init(map: [String: AnyObject]) {
//        self.id = map["id"]
//        self.text = map["text"]
//    }
//}

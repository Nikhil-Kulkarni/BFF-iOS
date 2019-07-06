//
//  QuestionsStore.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/5/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuestionsStore {
    
    var questions: [Question] = [Question]()
    
    static let sharedInstance = QuestionsStore()
    
    func fromJson(json: JSON?) {
        guard let json = json else {
            print("No questions value")
            return
        }
        
        questions.removeAll()
        for questionJson in json.arrayValue {
            let question = Question(json: questionJson.dictionaryValue)
            questions.append(question)
        }
    }
}

class ScoresStore {
    
    var scores: [Score] = [Score]()
    
    static let sharedInstance = ScoresStore()
    
    func fromJson(json: JSON?) {
        guard let json = json else {
            print("No scores value")
            return
        }
        
        scores.removeAll()
        for scoreJson in json.arrayValue.reversed() {
            let score = Score(json: scoreJson.dictionaryValue)
            scores.append(score)
        }
        
        scores.sort { (scoreA, scoreB) -> Bool in
            scoreA.timestamp > scoreB.timestamp
        }
    }
    
}

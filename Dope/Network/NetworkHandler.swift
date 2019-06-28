//
//  NetworkHandler.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/4/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let kBFFBaseUrl = "https://00f7fcd9.ngrok.io"
private let kBFFLoginEndpoint = "/Login"
private let kBFFFetchScoresEndpoint = "/FetchScores"
private let kBFFFetchQuestionsEndpoint = "/FetchQuestions"
private let kBFFCreateTestEndpoint = "/CreateTest"
private let kBFFFetchTestEndpoint = "/FetchTest"
private let kBFFSubmitScoreEndpoint = "/SubmitScore"
private let kSuccessRequestStatusCode = 200

class NetworkHandler {
    
    private let questionsStore = QuestionsStore.sharedInstance
    private let scoresStore = ScoresStore.sharedInstance
    
    func login(externalId: String, completion: @escaping (Bool) -> Void) {
        let parameters = ["userId": externalId]
        
        Alamofire.request(
            kBFFBaseUrl + kBFFLoginEndpoint,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding(options: .prettyPrinted),
            headers: nil).responseJSON { (data) in
                if (data.response?.statusCode != kSuccessRequestStatusCode) {
                    print(data.result)
                    completion(false)
                    return
                }
                
                guard let data = data.result.value else {
                    completion(false)
                    return
                }
                
                let jsonResponse = JSON(data)
                self.questionsStore.fromJson(json: jsonResponse.dictionaryValue["questions"])
                self.scoresStore.fromJson(json: jsonResponse.dictionaryValue["scores"])
                completion(true)
        }
    }
    
}

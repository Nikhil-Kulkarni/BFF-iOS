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

private let kBFFBaseUrl = "http://b85bca32.ngrok.io"
private let kBFFLoginEndpoint = "/Login"
private let kBFFFetchScoresEndpoint = "/FetchScores"
private let kBFFFetchQuestionsEndpoint = "/FetchQuestions"
private let kBFFCreateTestEndpoint = "/CreateTest"
private let kBFFFetchTestEndpoint = "/FetchTest"
private let kBFFSubmitScoreEndpoint = "/SubmitScore"

class NetworkHandler {
    
    func login() {
        Alamofire.request(
            kBFFBaseUrl + kBFFLoginEndpoint,
            method: .post,
            parameters: nil,
            encoding: JSONEncoding(options: .prettyPrinted),
            headers: nil).responseJSON { (data) in
                
        }
    }
    
}

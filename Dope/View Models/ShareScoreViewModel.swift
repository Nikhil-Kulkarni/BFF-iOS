//
//  ShareScoreViewModel.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/30/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class ShareScoreViewModel {
    
    private var score: Int
    private var name: String
    var bitmojiUrl: String?
    
    init(score: Int, name: String, userStore: UserStore) {
        self.score = score
        self.name = name
        self.bitmojiUrl = userStore.bitmojiUrl
    }
    
    var scoreText: String {
        return "\(score)%"
    }
    
    var scoreTextColor: UIColor {
        return ScoreUtils.getColorForScore(value: self.score)
    }
    
    var subtext: String {
        return ScoreUtils.getScoreSubtextForScore(value: self.score, friendName: self.name)
    }
    
    var swipeUpSubtext: String {
        return "Swipe up to find out who's your BFF"
    }
    
    var emoji: UIImage? {
        return ScoreUtils.getEmojiForScore(value: self.score)
    }
    
}

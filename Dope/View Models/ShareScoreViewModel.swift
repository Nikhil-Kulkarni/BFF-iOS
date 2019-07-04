//
//  ShareScoreViewModel.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/30/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class ShareScoreViewModel {
    
    enum StickerType {
        case SHARE_SCORE
        case SHARE_QUIZ
    }
    
    private var score: Int
    private var name: String?
    private var stickerType: StickerType
    var swipeUpSubtext: String
    var bitmojiUrl: String?
    
    init(score: Int, name: String?, userStore: UserStore, swipeUpSubtext: String, stickerType: StickerType) {
        self.score = score
        self.name = name
        self.swipeUpSubtext = swipeUpSubtext
        self.bitmojiUrl = userStore.bitmojiUrl
        self.stickerType = stickerType
    }
    
    var scoreText: String? {
        if (stickerType == .SHARE_QUIZ) {
            return nil
        }
        return "\(score)%"
    }
    
    var scoreTextColor: UIColor {
        return ScoreUtils.getColorForScore(value: self.score)
    }
    
    var centerLabelText: String? {
        if (stickerType == .SHARE_QUIZ) {
            return "Are you my BFF?"
        }
        return nil
    }
    
    var subtext: String? {
        guard let name = self.name else {
            return nil
        }
        if (stickerType == .SHARE_QUIZ) {
            return nil
        }
        return ScoreUtils.getScoreSubtextForScore(value: self.score, friendName: name)
    }
    
    var emoji: UIImage? {
        if (stickerType == .SHARE_QUIZ) {
            return UIImage(named: "happyEmoji")
        }
        return ScoreUtils.getEmojiForScore(value: self.score)
    }
    
}

//
//  ScoreUtils.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/25/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class ScoreUtils {
    
    static func getColorForScore(value: Int) -> UIColor {
        if (value <= 25) {
            return UIColor(red: 255/255.0, green: 107/255.0, blue: 107/255.0, alpha: 1.0)
        } else if (value <= 50) {
            return UIColor(red: 255/255.0, green: 160/255.0, blue: 107/255.0, alpha: 1.0)
        } else if (value <= 75) {
            return UIColor(red: 255/255.0, green: 223/255.0, blue: 107/255.0, alpha: 1.0)
        } else {
            return UIColor(red: 128/255.0, green: 255.0/255.0, blue: 107/255.0, alpha: 1.0)
        }
    }
    
    static func getEmojiForScore(value: Int) -> UIImage? {
        if (value >= 85) {
            return UIImage(named: "happyEmoji")
        } else if (value >= 50) {
            return UIImage(named: "blankEmoji")
        } else {
            return UIImage(named: "frownEmoji")
        }
    }
    
    static func getScoreSubtextForScore(value: Int, friendName: String) -> String {
        if (value >= 85) {
            return "\(friendName) is my BFF!!"
        } else if (value >= 50) {
            return "\(friendName) and I are just friends"
        } else {
            return "Ouch!! Who are you \(friendName)?"
        }

    }
    
}

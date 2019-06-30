//
//  ProfileCellViewModel.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/25/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

struct ProfileCellViewModel {
    var name: String
    var score: String
    var emoji: UIImage?
    var timestamp: String
    var scoreBarColor: UIColor
    var scoreBarMultiplier: CGFloat
    var rawScore: Int
}

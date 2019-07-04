//
//  ShareScoreStickerView.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/30/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

private let kEmojiViewSize: CGFloat = 36.0
private let kBitmojiViewSize: CGFloat = 40.0
private let kScoreLabelHeight: CGFloat = 31.0
private let kScoreLabelTextSize: CGFloat = 24.0
private let kScoreSubtextHeight: CGFloat = 22.0
private let kScoreSubtextTextSize: CGFloat = 16.0
private let kSwipeUpViewHeight: CGFloat = 39.0
private let kSwipeUpTextViewHeight: CGFloat = 18.0
private let kSwipeUpTextSize: CGFloat = 14.0

/**
 * Snap Sticker view hardcoded for width and height
 */
class ShareScoreStickerView: UIView {
    
    private var viewModel: ShareScoreViewModel!
    private var emojiImageView: UIImageView!
    private var bitmojiImageView: UIImageView!
    private var scoreLabel: UILabel!
    private var subtextLabel: UILabel!
    private var swipeUpView: UIView!
    private var swipeUpSubtextLabel: UILabel!
    private var centerLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(viewModel: ShareScoreViewModel) {
        let frame = CGRect(x: 0, y: 0, width: 290.0, height: 178.0)
        super.init(frame: frame)
        self.viewModel = viewModel
        self.roundCorners(.allCorners, radius: 8.0)
        self.backgroundColor = UIColor.white
        
        initEmojiView()
        initBitmojiView()
        initScoreLabel()
        initScoreSubtext()
        initCenterLabel()
        initSwipeUpView()
        initSwipeUpLabel()
    }
    
    private func initEmojiView() {
        let frame = CGRect(x: 103.0, y: 10.0, width: kEmojiViewSize, height: kEmojiViewSize)
        emojiImageView = UIImageView(frame: frame)
        emojiImageView.image = viewModel.emoji
        addSubview(emojiImageView)
    }
    
    private func initBitmojiView() {
        guard let bitmojiUrl = viewModel.bitmojiUrl else  {
            return
        }
        
        let frame = CGRect(x: 148.0, y: 5.0, width: kBitmojiViewSize, height: kBitmojiViewSize)
        bitmojiImageView = UIImageView(frame: frame)
        bitmojiImageView.sd_setImage(with: URL(string: bitmojiUrl), completed: nil)
        addSubview(bitmojiImageView)
    }
    
    private func initScoreLabel() {
        guard let scoreText = viewModel.scoreText else {
            return
        }
        let frame = CGRect(x: 0, y: 58.0, width: self.frame.width, height: kScoreLabelHeight)
        scoreLabel = UILabel(frame: frame)
        scoreLabel.text = scoreText
        scoreLabel.textColor = viewModel.scoreTextColor
        scoreLabel.font = UIFont(name: "Chewy-Regular", size: kScoreLabelTextSize)
        scoreLabel.textAlignment = .center
        addSubview(scoreLabel)
    }
    
    private func initScoreSubtext() {
        guard let subtext = viewModel.subtext else {
            return
        }
        let frame = CGRect(x: 0, y: 101.0, width: self.frame.width, height: kScoreSubtextHeight)
        subtextLabel = UILabel(frame: frame)
        subtextLabel.text = subtext
        subtextLabel.textColor = UIColor.black
        subtextLabel.font = UIFont.boldSystemFont(ofSize: kScoreSubtextTextSize)
        subtextLabel.textAlignment = .center
        addSubview(subtextLabel)
    }
    
    private func initCenterLabel() {
        guard let centerText = viewModel.centerLabelText else {
            return
        }
        let frame = CGRect(x: 0, y: 80.0, width: self.frame.width, height: kScoreSubtextHeight)
        centerLabel = UILabel(frame: frame)
        centerLabel.text = centerText
        centerLabel.textColor = UIColor.black
        centerLabel.font = UIFont.boldSystemFont(ofSize: kScoreSubtextTextSize)
        centerLabel.textAlignment = .center
        addSubview(centerLabel)
    }
    
    private func initSwipeUpView() {
        let frame = CGRect(x: 0, y: 139.0, width: self.frame.width, height: kSwipeUpViewHeight)
        swipeUpView = UIView(frame: frame)
        swipeUpView.backgroundColor = UIColor(red: 255/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
        swipeUpView.roundCornersDeprecated([.bottomLeft, .bottomRight], radius: 8.0)
        addSubview(swipeUpView)
    }
    
    private func initSwipeUpLabel() {
        let frame = CGRect(x: 0.0, y: 150.0, width: self.frame.width, height: kSwipeUpTextViewHeight)
        swipeUpSubtextLabel = UILabel(frame: frame)
        swipeUpSubtextLabel.text = viewModel.swipeUpSubtext
        swipeUpSubtextLabel.textColor = UIColor.white
        swipeUpSubtextLabel.font = UIFont(name: "Chewy-Regular", size: kSwipeUpTextSize)
        swipeUpSubtextLabel.textAlignment = .center
        addSubview(swipeUpSubtextLabel)
    }
    
}

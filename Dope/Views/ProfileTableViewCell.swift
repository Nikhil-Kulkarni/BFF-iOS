//
//  ProfileTableViewCell.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/28/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

private let kEmojiViewLeftMargin: CGFloat = 9.0
private let kEmojiViewSize: CGFloat = 40.0
private let kNameTextViewHeight: CGFloat = 20.0
private let kNameTextViewFontSize: CGFloat = 16.0
private let kScoreTextViewHeight: CGFloat = 20.0
private let kScoreTextViewFontSize: CGFloat = 12.0
private let kScoreTextViewTopMargin: CGFloat = 9.0
private let kScoreBarHeight: CGFloat = 6.0
private let kScoreBarTopMargin: CGFloat = 4.0
private let kContentContainerLeftMargin: CGFloat = 18.0
private let kContentContainerRightMargin: CGFloat = 24.0
private let kTimetstampViewHeight: CGFloat = 16.0
private let kTimestampFontSize: CGFloat = 12.0
private let kTimestampRightMargin: CGFloat = 24.0

class ProfileTableViewCell: UITableViewCell {
    
    private var emojiView = UIImageView()
    private var nameTextView = UILabel()
    private var scoreTextView = UILabel()
    private var timestampTextView = UILabel()
    private var scoreBarView = UIView()
    private var scoreBarMaxWidth: CGFloat!
    private var scoreBarMultiplier: CGFloat!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        scoreBarMaxWidth = UIScreen.main.bounds.width - kContentContainerRightMargin - (kEmojiViewSize + kContentContainerLeftMargin)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initEmojiView()
        initNameTextView()
        initScoreTextView()
        initScoreBarTextView()
    }
    
    private func initEmojiView() {
        let y = contentView.frame.height / 2 - kEmojiViewSize / 2
        let frame = CGRect(x: kEmojiViewLeftMargin, y: y, width: kEmojiViewSize, height: kEmojiViewSize)
        emojiView.frame = frame
        contentView.addSubview(emojiView)
    }
    
    private func initNameTextView() {
        let y = contentView.frame.height / 2 - kNameTextViewHeight
        let frame = CGRect(x: emojiView.frame.maxX + kContentContainerLeftMargin, y: y, width: contentView.frame.width * 0.8, height: kNameTextViewHeight)
        nameTextView.frame = frame
        nameTextView.textAlignment = .left
        nameTextView.textColor = UIColor.black
        nameTextView.font = UIFont.boldSystemFont(ofSize: kNameTextViewFontSize)
        contentView.addSubview(nameTextView)
    }
    
    private func initScoreTextView() {
        let y = nameTextView.frame.maxY + kScoreBarTopMargin
        let frame = CGRect(x: emojiView.frame.maxX + kContentContainerLeftMargin, y: y, width: contentView.frame.width * 0.4, height: kScoreTextViewHeight)
        scoreTextView.frame = frame
        scoreTextView.textAlignment = .left
        scoreTextView.textColor = UIColor.black
        scoreTextView.font = UIFont.systemFont(ofSize: kScoreTextViewFontSize)
        contentView.addSubview(scoreTextView)
    }
    
    private func initScoreBarTextView() {
        let y = scoreTextView.frame.maxY + kScoreBarTopMargin
        let frame = CGRect(x: emojiView.frame.maxX + kContentContainerLeftMargin, y: y, width: scoreBarMaxWidth * scoreBarMultiplier, height: kScoreBarHeight)
        scoreBarView.frame = frame
        scoreBarView.roundCorners(.allCorners, radius: kScoreBarHeight / 2)
        contentView.addSubview(scoreBarView)
    }
    
    func bind(viewModel: ProfileCellViewModel) {
        emojiView.image = viewModel.emoji
        nameTextView.text = viewModel.name
        scoreTextView.text = viewModel.score
        scoreBarView.backgroundColor = viewModel.scoreBarColor
        scoreBarMultiplier = viewModel.scoreBarMultiplier
    }
    
}

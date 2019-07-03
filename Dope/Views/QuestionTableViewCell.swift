//
//  QuestionTableViewCell.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 7/3/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

private let kContainerViewHeight: CGFloat = 52.0
private let kContainerViewSidePadding: CGFloat = 25.0
private let kContainerViewBorderWidth: CGFloat = 2.0
private let kContainerViewBorderRadius: CGFloat = 10.0

private let kChoiceLabelTextSize: CGFloat = 24.0

class QuestionTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let choiceLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initContainerView()
        initChoiceLabel()
    }
    
    private func initContainerView() {
        let y = contentView.frame.height / 2 - kContainerViewHeight / 2
        let frame = CGRect(x: kContainerViewSidePadding, y: y, width: contentView.frame.width - kContainerViewSidePadding * 2, height: kContainerViewHeight)
        containerView.frame = frame
        containerView.backgroundColor = UIColor.white
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = kContainerViewBorderWidth
        containerView.roundCorners(.allCorners, radius: kContainerViewBorderRadius)
        contentView.addSubview(containerView)
    }
    
    private func initChoiceLabel() {
        choiceLabel.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        choiceLabel.font = UIFont(name: "Chewy-Regular", size: kChoiceLabelTextSize)
        choiceLabel.textAlignment = .center
        containerView.addSubview(choiceLabel)
    }
    
    func bind(viewModel: QuestionsCellViewModel?) {
        choiceLabel.text = viewModel?.choiceText
    }
    
}

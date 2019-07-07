//
//  HeaderTableViewCell.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/29/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

private let kBitmojiButtonBottomMargin: CGFloat = 20.0
private let kBitmojiButtonTopMargin: CGFloat = 12.0
private let kBitmojiButtonRightMargin: CGFloat = 12.0
private let kBitmojiButtonSize: CGFloat = 48.0
private let kHeaderTextLeftMargin: CGFloat = 18.0
private let kHeaderTextSize: CGFloat = 24.0
private let kHeaderTextViewHeight: CGFloat = 30.0

protocol HeaderTableViewCellDelegate {
    func onBitmojiButtonClicked()
}

class HeaderTableViewCell: UITableViewCell {
    
    private let bitmojiButton = UIButton()
    private let headerLabel = UILabel()
    var delegate: HeaderTableViewCellDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        initBitmojiButton()
        initHeaderLabel()
    }
    
    private func initBitmojiButton() {
        let x = contentView.frame.width - kBitmojiButtonSize - kBitmojiButtonRightMargin
        let y = contentView.frame.height / 2 - kBitmojiButtonSize / 2
        let frame = CGRect(x: x, y: y, width: kBitmojiButtonSize, height: kBitmojiButtonSize)
        bitmojiButton.frame = frame
        bitmojiButton.addTarget(self, action: #selector(onBitmojiClicked), for: .touchUpInside)
        contentView.addSubview(bitmojiButton)
    }
    
    private func initHeaderLabel() {
        let y = contentView.frame.height / 2 - kHeaderTextViewHeight / 2
        let frame = CGRect(x: kHeaderTextLeftMargin, y: y, width: contentView.frame.width * 0.6, height: kHeaderTextViewHeight)
        headerLabel.frame = frame
        headerLabel.font = UIFont(name: "Chewy-Regular", size: kHeaderTextSize)
        headerLabel.textColor = UIColor.black
        contentView.addSubview(headerLabel)
    }
    
    @objc private func onBitmojiClicked() {
        delegate?.onBitmojiButtonClicked()
    }
    
    func bind(viewModel: HeaderCellViewModel) {
        headerLabel.text = viewModel.headerText
        guard let bitmojiUrl = viewModel.bitmojiImageUrl else {
            return
        }
        bitmojiButton.sd_setImage(with: URL(string: bitmojiUrl), for: .normal, completed: nil)
    }
    
}

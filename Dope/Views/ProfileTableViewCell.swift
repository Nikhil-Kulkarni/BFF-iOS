//
//  ProfileTableViewCell.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/28/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    private var emojiView: UIImageView!
    private var nameTextView: UITextView!
    private var scoreTextView: UITextView!
    private var timestampTextView: UITextView!
    private var scoreBarView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        // TODO
    }
    
    func bind(viewModel: ProfileCellViewModel) {
        
    }
    
}

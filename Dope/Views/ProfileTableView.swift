//
//  ProfileTableView.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/28/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class ProfileTableView: UITableView {
    
    static let itemReuseIdentifier = "ProfileTableViewCell"
    static let headerReuseIdentifier = "HeaderReuseIdentifier"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = UIColor.white
        register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableView.itemReuseIdentifier)
        register(HeaderTableViewCell.self, forCellReuseIdentifier: ProfileTableView.headerReuseIdentifier)
        separatorStyle = .none
    }
    
}

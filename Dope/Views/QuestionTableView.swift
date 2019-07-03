//
//  QuestionTableView.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 7/3/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class QuestionTableView: UITableView {
    
    static let reuseIdentifer = "reuseIdentifier"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = .white
        separatorStyle = .none
        register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableView.reuseIdentifer)
    }
    
}

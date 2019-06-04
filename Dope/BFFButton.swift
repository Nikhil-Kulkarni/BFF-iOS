//
//  BFFButton.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/3/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

let kBFFButtonLeftPadding: CGFloat = 16.0
let kBFFButtonImageWidth : CGFloat = 21.0

class BFFButton: UIButton {
    
    private let leftImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, image: UIImage?) {
        super.init(frame: frame)
        setImage(image: image)
    }
    
    private func setImage(image: UIImage?) {
        leftImageView.frame = CGRect(x: kBFFButtonLeftPadding, y: 0, width: kBFFButtonImageWidth, height: frame.height)
        leftImageView.image = image
        leftImageView.contentMode = .scaleAspectFit
        addSubview(leftImageView)
    }
    
}

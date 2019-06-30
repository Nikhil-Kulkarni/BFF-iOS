//
//  LogoViewController.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/29/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

private let kBFFLogoViewWidth: CGFloat = 80.0
private let kBFFLogoViewHeight: CGFloat = 46.66

class LogoViewController: UIViewController {
    
    private var logoView: UIImageView!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        createLogoView()
    }
    
    private func createLogoView() {
        let frame = CGRect(x: view.frame.width / 2 - kBFFLogoViewWidth / 2, y: view.frame.height / 2 - kBFFLogoViewHeight / 2, width: kBFFLogoViewWidth, height: kBFFLogoViewHeight)
        logoView = UIImageView(frame: frame)
        logoView.image = UIImage(named: "logo")
        
        view.addSubview(logoView)
    }
    
}

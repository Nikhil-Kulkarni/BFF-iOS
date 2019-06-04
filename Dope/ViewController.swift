//
//  ViewController.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 5/22/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SCSDKLoginKit

let kBFFLoginButtonSidePadding: CGFloat = 30.0
let kBFFLoginButtonBottomPadding: CGFloat = 28.0
let kBFFLoginButtonHeight: CGFloat = 54.0
let kBFFLoginButtonCornerRadius: CGFloat = 8.0
let kBFFLogoViewWidth: CGFloat = 80.0
let kBFFLogoViewHeight: CGFloat = 46.66

class ViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    private var safeArea: UIEdgeInsets?
    private var loginButton: UIButton!
    private var logoView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        
        createLoginButton()
        createLogoView()
    }
    
    private func createLoginButton() {
        let screenWidth = view.frame.width
        let bottomPadding = DisplayUtils.isIphoneX() ? safeArea!.bottom : kBFFLoginButtonBottomPadding
        let frame = CGRect(x: kBFFLoginButtonSidePadding, y: view.frame.height - kBFFLoginButtonHeight - bottomPadding, width: screenWidth - 2 * kBFFLoginButtonSidePadding, height: kBFFLoginButtonHeight)
        
        loginButton = BFFButton(frame: frame, image: UIImage(named: "ghost"))
        loginButton.backgroundColor = UIColor(red: 255/255.0, green: 252/255.0, blue: 0.0, alpha: 1.0)
        loginButton.setTitle("Login with Snapchat", for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        loginButton.roundCorners(UIRectCorner.allCorners, radius: kBFFLoginButtonCornerRadius)
        loginButton.dropShadow(color: UIColor.black, opacity: 0.15, offSet: CGSize(width: 4.0, height: 4.0), radius: kBFFLoginButtonCornerRadius, scale: true)
        loginButton.addTarget(self, action: #selector(onClickedLoginButton), for: .touchUpInside)
        
        view.addSubview(loginButton)
    }
    
    private func createLogoView() {
        let frame = CGRect(x: view.frame.width / 2 - kBFFLogoViewWidth / 2, y: view.frame.height / 2 - kBFFLogoViewHeight / 2, width: kBFFLogoViewWidth, height: kBFFLogoViewHeight)
        logoView = UIImageView(frame: frame)
        logoView.image = UIImage(named: "logo")
        
        view.addSubview(logoView)
    }
    
    @objc private func onClickedLoginButton() {
        SCSDKLoginClient.login(from: self) { (success, error) in
            if (success){
                self.coordinator?.showProfile()
            } else {
                
            }
        }
    }

}


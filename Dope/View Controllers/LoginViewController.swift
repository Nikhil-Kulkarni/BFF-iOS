//
//  ViewController.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 5/22/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SCSDKLoginKit

private let kBFFLoginButtonSidePadding: CGFloat = 30.0
private let kBFFLoginButtonBottomPadding: CGFloat = 28.0
private let kBFFLoginButtonHeight: CGFloat = 54.0
private let kBFFLoginButtonCornerRadius: CGFloat = 10.0
private let kBFFLogoViewWidth: CGFloat = 80.0
private let kBFFLogoViewHeight: CGFloat = 46.66

class LoginViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    private var safeArea: UIEdgeInsets?
    private var loginButton: UIButton!
    private var logoView: UIImageView!
    private var indicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        
        createLoginButton()
        createLogoView()
        createIndicatorView()
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
    
    private func createIndicatorView() {
        indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.frame = self.view.frame
        indicatorView.backgroundColor = UIColor(red: 196/255.0, green: 195/255.0, blue: 196/255.0, alpha: 0.55)
    }
    
    @objc private func onClickedLoginButton() {
        SCSDKLoginClient.login(from: self) { (success, error) in
            if (success) {
                DispatchQueue.main.async {
                    self.indicatorView.startAnimating()
                    self.view.addSubview(self.indicatorView)
                }
                self.coordinator?.login(completion: { (success) in
                    DispatchQueue.main.async {
                        self.indicatorView.stopAnimating()
                        self.indicatorView.removeFromSuperview()
                    }
                    if (!success) {
                        self.showLoginFailureAlert()
                    }
                })
            } else {
                self.showLoginFailureAlert()
            }
        }
    }
    
    private func showLoginFailureAlert() {
        DispatchQueue.main.async {
            let alertView = UIAlertController.init(title: "Failed to login", message: "Oh no! Something went wrong. Please try again.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
    }

}


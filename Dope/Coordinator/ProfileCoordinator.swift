//
//  ProfileCoordinator.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/25/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SCSDKCreativeKit

class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var userStore: UserStore
    private var scoreStore: ScoresStore
    
    init(navigationController: UINavigationController, userStore: UserStore, scoreStore: ScoresStore) {
        self.navigationController = navigationController
        self.userStore = userStore
        self.scoreStore = scoreStore
    }
    
    func start() {
        let viewModel = ProfileViewModel(userStore: userStore, scoresStore: scoreStore)
        let profileVC = ProfileViewController()
        
        profileVC.coordinator = self
        profileVC.viewModel = viewModel
        self.navigationController.pushViewController(profileVC, animated: true)
        self.navigationController.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func postFriendScoreToSnap(value: Int, friendName: String) {
        let alert = UIAlertController(title: "Post to Snapchat?", message: "Do you want to post your BFFs to Snapchat?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            let shareScoreViewModel = ShareScoreViewModel(score: value, name: friendName, userStore: self.userStore)
            let scoreViewSticker = ShareScoreStickerView(viewModel: shareScoreViewModel)
            let sticker = SCSDKSnapSticker(stickerImage: scoreViewSticker.toImage())
            let snap = SCSDKNoSnapContent()
            snap.sticker = sticker
            
            let snapAPI = SCSDKSnapAPI(content: snap)
            snapAPI.startSnapping { (error) in
                print(error?.localizedDescription)
            }
        }))
        DispatchQueue.main.async {
            self.navigationController.present(alert, animated: true, completion: nil)
        }
    }
    
    func askFriends() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100.0, height: 100.0))
        view.backgroundColor = UIColor.blue
        let sticker = SCSDKSnapSticker(stickerImage: view.toImage())
        let snap = SCSDKNoSnapContent()
        snap.sticker = sticker
        snap.attachmentUrl = "https://www.google.com"
        
        let snapAPI = SCSDKSnapAPI(content: snap)
        snapAPI.startSnapping { (error) in
            print(error?.localizedDescription)
        }
    }
    
}

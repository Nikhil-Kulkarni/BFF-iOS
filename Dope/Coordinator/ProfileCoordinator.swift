//
//  ProfileCoordinator.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/25/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SCSDKCreativeKit
import SCSDKLoginKit

class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var userStore: UserStore!
    private var scoreStore: ScoresStore!
    private var networkHandler: NetworkHandler!
    private var questionsCoordinator: QuestionsCoordinator!
    
    init(navigationController: UINavigationController, userStore: UserStore, scoreStore: ScoresStore, networkHandler: NetworkHandler) {
        self.navigationController = navigationController
        self.userStore = userStore
        self.scoreStore = scoreStore
        self.networkHandler = networkHandler
    }
    
    func start() {
        let viewModel = ProfileViewModel(userStore: userStore, scoresStore: scoreStore, networkHandler: networkHandler)
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
            let shareScoreViewModel = ShareScoreViewModel(score: value, name: friendName, userStore: self.userStore, swipeUpSubtext: "Swipe up to find out who's your BFF", stickerType: .SHARE_SCORE)
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
        questionsCoordinator = QuestionsCoordinator(
            navigationController: self.navigationController,
            userStore: self.userStore,
            questionsStore: QuestionsStore.sharedInstance)
        questionsCoordinator.start()
    }
    
    func onBitmojiButtonClicked() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            SCSDKLoginClient.unlinkCurrentSession(completion: { (success) in
                let loginController = LoginViewController()
                DispatchQueue.main.async {
                    self.navigationController.present(loginController, animated: false, completion: nil)
                }
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(logoutAction)
        optionMenu.addAction(cancelAction)
        DispatchQueue.main.async {
            self.navigationController.present(optionMenu, animated: true, completion: nil)
        }
    }
    
}

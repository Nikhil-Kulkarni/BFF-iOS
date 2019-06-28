//
//  ProfileCoordinator.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/25/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var userStore: UserStore
    var scoreStore: ScoresStore
    
    func start() {
        let viewModel = ProfileViewModel(userStore: userStore, scoresStore: scoreStore)
        let profileVC = ProfileViewController()
        
        profileVC.coordinator = self
        profileVC.viewModel = viewModel
        self.navigationController.pushViewController(profileVC, animated: true)
    }
    
    func askFriends() {
        
    }
    
    init(navigationController: UINavigationController, userStore: UserStore, scoreStore: ScoresStore) {
        self.navigationController = navigationController
        self.userStore = userStore
        self.scoreStore = scoreStore
    }
    
}

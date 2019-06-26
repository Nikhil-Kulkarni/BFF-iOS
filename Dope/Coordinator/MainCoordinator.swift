//
//  MainCoordinator.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 5/24/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SCSDKLoginKit

private let kSCGraphQLQuery = "{me{displayName, externalId, bitmoji{avatar}}}"
private let kSCVariables = ["page": "bitmoji"]

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private let userStore = UserStore.sharedInstance
    private let scoresStore = ScoresStore.sharedInstance
    private let networkHandler = NetworkHandler()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchSCUserData { (success, userId) in
                if (success) {
                    self.loginRequest(externalId: userId!, completion: completion)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    private func loginRequest(externalId: String, completion: @escaping (Bool) -> Void) {
        networkHandler.login(externalId: externalId) { (success) in
            if (success) {
                let profileCoordinator = ProfileCoordinator(
                    navigationController: self.navigationController,
                    userStore: self.userStore,
                    scoreStore: self.scoresStore)
                DispatchQueue.main.async {
                    profileCoordinator.start()
                }
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    private func fetchSCUserData(completion: @escaping (Bool, String?) -> Void) {
        SCSDKLoginClient.fetchUserData(withQuery: kSCGraphQLQuery, variables: kSCVariables, success: { (resources) in
            guard let resources = resources,
                let data = resources["data"] as? [String : Any],
                let me = data["me"] as? [String: Any] else {
                    completion(false, nil)
                    return
            }
            
            let displayName = me["displayName"] as? String
            let externalId = me["externalId"] as? String
            var bitmojiAvatarUrl: String?
            if let bitmoji = me["bitmoji"] as? [String: Any] {
                bitmojiAvatarUrl = bitmoji["avatar"] as? String
            }
            
            guard let userId = externalId else {
                completion(false, nil)
                return
            }
            self.userStore.setUserProfile(externalId: userId, bitmojiUrl: bitmojiAvatarUrl, displayName: displayName)
            completion(true, userId)
        }, failure: { (error, isUserLoggedOut) in
            completion(false, nil)
        })
    }
}

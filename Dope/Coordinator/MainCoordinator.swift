//
//  MainCoordinator.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 5/24/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SCSDKLoginKit

let kSCGraphQLQuery = "{me{displayName, externalId, bitmoji{avatar}}}"
let kSCVariables = ["page": "bitmoji"]

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private let userStore = UserStore.sharedInstance
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfile() {
        fetchSCUserData { (success) in
            if (success) {
                DispatchQueue.main.async {
                    let vc = ProfileViewController()
                    vc.coordinator = self
                    self.navigationController.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    private func fetchSCUserData(completion: @escaping (Bool) -> Void) {
        SCSDKLoginClient.fetchUserData(withQuery: kSCGraphQLQuery, variables: kSCVariables, success: { (resources) in
            guard let resources = resources,
                let data = resources["data"] as? [String : Any],
                let me = data["me"] as? [String: Any] else {
                    return
            }
            
            let displayName = me["displayName"] as? String
            let externalId = me["externalId"] as? String
            var bitmojiAvatarUrl: String?
            if let bitmoji = me["bitmoji"] as? [String: Any] {
                bitmojiAvatarUrl = bitmoji["avatar"] as? String
            }
            
            guard let userId = externalId else {
                completion(false)
                return
            }
            self.userStore.setUserProfile(externalId: userId, bitmojiUrl: bitmojiAvatarUrl, displayName: displayName)
            
            completion(true)
        }, failure: { (error, isUserLoggedOut) in
            completion(false)
        })
    }
}

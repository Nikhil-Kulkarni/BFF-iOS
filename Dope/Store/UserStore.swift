//
//  UserStore.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/4/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import Foundation

class UserStore: NSObject {
    
    var externalId: String?
    var bitmojiUrl: String?
    var displayName: String?
    
    static let sharedInstance = UserStore()
    
    func setUserProfile(externalId: String, bitmojiUrl: String?, displayName: String?) {
        self.externalId = externalId
        self.bitmojiUrl = bitmojiUrl
        self.displayName = displayName
    }
    
}

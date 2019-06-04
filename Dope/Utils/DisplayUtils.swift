//
//  DisplayUtils.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/3/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class DisplayUtils {
    class func isIphoneX() -> Bool {
        
        // figure out screen height (portrait)
        let height = Int(UIScreen.main.fixedCoordinateSpace.bounds.size.height)
        
        // based on the height, give out an NSString for device type
        var deviceModel: Bool
        
        switch height {
        case 568:
            deviceModel = false
        case 667:
            deviceModel = false
        case 736:
            deviceModel = false
        case 812:
            deviceModel = true
        default:
            deviceModel = false
        }
        return deviceModel
    }
}

//
//  Coordinator.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 5/24/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}

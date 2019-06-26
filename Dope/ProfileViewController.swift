//
//  ProfileViewController.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/3/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel?
    
    private let questionsStore = QuestionsStore.sharedInstance
    private let scoresStore = ScoresStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }

}

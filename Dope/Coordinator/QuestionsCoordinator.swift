//
//  QuestionsCoordinator.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/30/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class QuestionsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var userStore: UserStore
    private var questionsStore: QuestionsStore
    
    init(navigationController: UINavigationController, userStore: UserStore, questionsStore: QuestionsStore) {
        self.navigationController = navigationController
        self.userStore = userStore
        self.questionsStore = questionsStore
    }
    
    func start() {
        let viewModel = QuestionsViewModel(userStore: self.userStore, questionsStore: self.questionsStore)
        let vc = QuestionsViewController()
        vc.coordinator = self
        vc.viewModel = viewModel
        
        DispatchQueue.main.async {
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
    
}

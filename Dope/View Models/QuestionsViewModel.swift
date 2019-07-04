//
//  QuestionsViewModel.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/30/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SCSDKCreativeKit

private let kDispatchQueueLabel = "com.nikhil.bff.CreateTest"

class QuestionsViewModel {
    
    enum QuestionsState {
        case INTRO
        case QUESTION
        case FINAL
    }
    
    weak var coordinator: QuestionsCoordinator!
    private var userStore: UserStore!
    private var questionsStore: QuestionsStore!
    private var questionNumber = 0
    private var randomNumber = 0
    private var submittedQuestions: [[String: String]] = [[String: String]]()
    
    private let networkHandler = NetworkHandler()
    
    init(userStore: UserStore, questionsStore: QuestionsStore) {
        self.userStore = userStore
        self.questionsStore = questionsStore
       generateNewQuestion()
    }
    
    var reloadPage: (() -> ())?
    var animateIndicatorView: ((Bool) -> ())?
    
    var state: QuestionsState = .INTRO {
        didSet {
            self.reloadPage?()
        }
    }
    
    var introText: String {
        if (state == .INTRO) {
            return "Ask your friends 5 questions to see who's your BFF 🤗"
        }
        
        return ""
    }
    
    var questionText: String? {
        if (state == .INTRO || state == .FINAL) {
            return ""
        }
        return question?.text
    }
    
    var questonNo: Int {
        return questionNumber + 1
    }
    
    var cellViewModels: [QuestionsCellViewModel]? {
        if (state == .INTRO || state == .FINAL) {
            return nil
        }
        
        var viewModels = [QuestionsCellViewModel]()
        for choice in question!.choices {
            viewModels.append(createCellViewModel(choice: choice))
        }
        return viewModels
    }
    
    private var question: Question? {
        if (state == .INTRO || state == .FINAL) {
            return nil
        }
        return questionsStore.questions[randomNumber]
    }
    
    func onPrimaryButtonClicked() {
        switch state {
        case .INTRO:
            self.state = .QUESTION
        case .QUESTION:
            generateNewQuestion()
            self.reloadPage?()
        case .FINAL:
            self.postQuizToSnapchat()
        }
    }
    
    func primaryButtonText() -> String {
        if (state == .INTRO) {
            return "Ready"
        } else if (state == .QUESTION) {
            return ""
        } else {
            return "Post Quiz to Snapchat"
        }
    }
    
    func primaryButtonImage() -> UIImage? {
        if (state == .QUESTION) {
            return UIImage(named: "shuffle")
        }
        return nil
    }
    
    func primaryButtonLeftImage() -> UIImage? {
        if (state == .FINAL) {
            return UIImage(named: "ghost")
        }
        return nil
    }
    
    func primaryButtonBackgroundColor() -> UIColor {
        if (state == .INTRO || state == .QUESTION) {
            return UIColor(red: 255/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
        }
        return UIColor(red: 255/255.0, green: 252/255.0, blue: 0.0, alpha: 1.0)
    }
    
    func primaryButtonTextColor() -> UIColor {
        if (state == .INTRO || state == .QUESTION) {
            return UIColor.white
        }
        return UIColor.black
    }
    
    func onChoiceSelected(choiceIndex: Int) {
        saveChoice(choiceIndex: choiceIndex)
        if (questionNumber == 4) {
            self.state = .FINAL
            return
        }
        
        generateNewQuestion()
        questionNumber += 1
        self.reloadPage?()
    }
    
    func shareStickerView() -> ShareScoreStickerView? {
        if (state == .INTRO || state == .QUESTION) {
            return nil
        }
        
        let viewModel = ShareScoreViewModel(score: 0, name: nil, userStore: self.userStore, swipeUpSubtext: "Swipe up to find out", stickerType: .SHARE_QUIZ)
        return ShareScoreStickerView(viewModel: viewModel)
    }
    
    private func generateNewQuestion() {
        self.randomNumber = Int(arc4random_uniform(UInt32(questionsStore.questions.count)))
    }
    
    private func saveChoice(choiceIndex: Int) {
        let choiceId = question?.choices[choiceIndex].id
        let questionId = question?.id
        
        guard let choice = choiceId, let question = questionId else {
            return
        }
        self.submittedQuestions.append(["id": question, "selectedChoiceId": choice])
    }
    
    private func createCellViewModel(choice: Choice) -> QuestionsCellViewModel {
        return QuestionsCellViewModel(choiceText: choice.text)
    }
    
    private func postQuizToSnapchat() {
        guard let view = shareStickerView() else {
            return
        }
        animateIndicatorView?(true)
        let sticker = SCSDKSnapSticker(stickerImage: view.toImage())
        let snap = SCSDKNoSnapContent()
        snap.sticker = sticker
        
        let queue = DispatchQueue(
            label: kDispatchQueueLabel,
            qos: .userInitiated)
        networkHandler.createTest(
            userId: self.userStore.externalId,
            submittedQuestions: submittedQuestions,
            dispatchQueue: queue) { (success, url) in
                guard let attachmentUrl = url else {
                    return
                }
                
                // TODO: Un-hardcode
                snap.attachmentUrl = "https://www.google.com"
                let snapAPI = SCSDKSnapAPI(content: snap)
                
                DispatchQueue.main.async {
                    self.animateIndicatorView?(false)
                    snapAPI.startSnapping { (error) in
                        self.coordinator.pop()
                    }
                }
        }
    }
    
}

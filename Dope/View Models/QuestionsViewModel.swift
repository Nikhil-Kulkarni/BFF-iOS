//
//  QuestionsViewModel.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/30/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SCSDKCreativeKit

class QuestionsViewModel {
    
    enum QuestionsState {
        case INTRO
        case QUESTION
        case FINAL
    }
    
    private var userStore: UserStore!
    private var questionsStore: QuestionsStore!
    private var questionNumber = 0
    private var randomNumber = 0
    private var submittedQuestions: [[String: String]] = [[String: String]]()
    
    init(userStore: UserStore, questionsStore: QuestionsStore) {
        self.userStore = userStore
        self.questionsStore = questionsStore
       generateNewQuestion()
    }
    
    var reloadPage: (() -> ())?
    
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
        if (questionNumber == 4) {
            self.state = .FINAL
            return
        }
        
        saveChoice(choiceIndex: choiceIndex)
        generateNewQuestion()
        questionNumber += 1
        self.reloadPage?()
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
        // TODO: update
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100.0, height: 100.0))
        view.backgroundColor = UIColor.blue
        let sticker = SCSDKSnapSticker(stickerImage: view.toImage())
        let snap = SCSDKNoSnapContent()
        snap.sticker = sticker
        snap.attachmentUrl = "https://www.google.com"
        
        let snapAPI = SCSDKSnapAPI(content: snap)
        snapAPI.startSnapping { (error) in
            print(error?.localizedDescription)
        }
    }
    
}

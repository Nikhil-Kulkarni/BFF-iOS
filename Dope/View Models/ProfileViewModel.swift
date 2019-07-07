//
//  ProfileViewModel.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/24/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

private let kFetchScoreQueue = "com.nikhil.Dope.FetchScore"

class ProfileViewModel {

    enum LoadingState {
        case Success
        case Loading
        case Failed
    }
    
    private var networkHandler: NetworkHandler!
    private var userId: String!
    
    init(userStore: UserStore, scoresStore: ScoresStore, networkHandler: NetworkHandler) {
        let scores = scoresStore.scores
        let bitmojiUrl = userStore.bitmojiUrl
        
        self.networkHandler = networkHandler
        self.userId = userStore.externalId
        self.bitmojiUrl = bitmojiUrl
        processFetchedScores(scores: scores)
    }
    
    var loadingState: LoadingState = LoadingState.Loading {
        didSet {
            self.loadingStateClosure?()
        }
    }
    var bitmojiUrl: String?
    var numberOfCells: Int {
        return cellViewModels.count + 1
    }
    var reloadTableViewClosure: (() ->())?
    var loadingStateClosure: (() -> ())?
    
    func headerViewModel() -> HeaderCellViewModel {
        return HeaderCellViewModel(bitmojiImageUrl: self.bitmojiUrl, headerText: "Who's your BFF?")
    }
    
    func getViewModel(row: Int) -> ProfileCellViewModel {
        return cellViewModels[row]
    }
    
    func onRefreshed(completion: @escaping (Bool) -> Void) {
        let dispatchQueue = DispatchQueue(
            label: kFetchScoreQueue,
            qos: .userInitiated)
        networkHandler.fetchScores(
            userId: self.userId,
            dispatchQueue: dispatchQueue,
            completion: completion)
    }
    
    private var cellViewModels = [ProfileCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    private func createCellViewModel(score: Score) -> ProfileCellViewModel {
        let formattedScore = "\(String(describing: score.value!))%"
        let formattedTimestamp = TimestampUtils.getStringForTimestamp(timestamp: score.timestamp)
        let emojiImage = ScoreUtils.getEmojiForScore(value: score.value)
        let scoreBarColor = ScoreUtils.getColorForScore(value: score.value)
        let scoreBarMultipler = CGFloat(score.value) / 100.0
        
        return ProfileCellViewModel(
            name: score.name,
            score: formattedScore,
            emoji: emojiImage,
            timestamp: formattedTimestamp,
            scoreBarColor: scoreBarColor,
            scoreBarMultiplier: scoreBarMultipler,
            rawScore: score.value)
    }
    
    private func processFetchedScores(scores: [Score]) {
        var viewModels = [ProfileCellViewModel]()
        for score in scores {
            let cellViewModel = createCellViewModel(score: score)
            viewModels.append(cellViewModel)
        }
        self.loadingState = LoadingState.Success
        self.cellViewModels = viewModels
    }
    
}

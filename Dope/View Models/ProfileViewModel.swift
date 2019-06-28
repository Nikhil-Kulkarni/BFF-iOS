//
//  ProfileViewModel.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/24/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

class ProfileViewModel {

    enum LoadingState {
        case Success
        case Loading
        case Failed
    }
    
    init(userStore: UserStore, scoresStore: ScoresStore) {
        let scores = scoresStore.scores
        let bitmojiUrl = userStore.bitmojiUrl
        
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
        return cellViewModels.count
    }
    var reloadTableViewClosure: (() ->())?
    var loadingStateClosure: (() -> ())?
    
    func getViewModel(indexPath: IndexPath) -> ProfileCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    private var cellViewModels = [ProfileCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    private func createCellViewModel(score: Score) -> ProfileCellViewModel {
        let formattedScore = "\(String(describing: score.value))%"
        let formattedTimestamp = TimestampUtils.getStringForTimestamp(timestamp: score.timestamp)
        let emojiImage = UIImage(named: "TODO")
        let scoreBarColor = ScoreUtils.getColorForScore(value: score.value)
        let scoreBarMultipler = Float(score.value) / 100.0
        
        return ProfileCellViewModel(
            name: score.name,
            score: formattedScore,
            emoji: emojiImage,
            timestamp: formattedTimestamp,
            scoreBarColor: scoreBarColor,
            scoreBarMultiplier: scoreBarMultipler)
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

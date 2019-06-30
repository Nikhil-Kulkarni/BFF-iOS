//
//  ProfileViewController.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/3/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SDWebImage

private let kBitmojiButtonSize: CGFloat = 48.0
private let kAskFriendsButtonSidePadding: CGFloat = 30.0
private let kAskFriendsButtonBottomPadding: CGFloat = 28.0
private let kAskFriendsButtonHeight: CGFloat = 54.0
private let kAskFriendsButtonCornerRadius: CGFloat = 10.0
private let kProfileCellHeight: CGFloat = 76.0

class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel!
    
    private var safeArea: UIEdgeInsets!
    private var findBFFBButton: BFFButton!
    private var tableView: ProfileTableView!
    
    private let questionsStore = QuestionsStore.sharedInstance
    private let scoresStore = ScoresStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        
        initTableView()
        initAskFriendsButton()
    }
    
    private func initTableView() {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView = ProfileTableView(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func initAskFriendsButton() {
        let screenWidth = view.frame.width
        let bottomPadding = DisplayUtils.isIphoneX() ? safeArea.bottom : kAskFriendsButtonBottomPadding
        let frame = CGRect(x: kAskFriendsButtonSidePadding, y: view.frame.height - kAskFriendsButtonHeight - bottomPadding, width: screenWidth - 2 * kAskFriendsButtonSidePadding, height: kAskFriendsButtonHeight)
        
        findBFFBButton = BFFButton(frame: frame, image: nil)
        findBFFBButton.backgroundColor = UIColor(red: 255/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
        findBFFBButton.setTitle("Find my BFFs", for: .normal)
        findBFFBButton.setTitleColor(UIColor.white, for: .normal)
        findBFFBButton.titleLabel?.textAlignment = .center
        findBFFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        findBFFBButton.roundCorners(UIRectCorner.allCorners, radius: kAskFriendsButtonCornerRadius)
        findBFFBButton.dropShadow(color: UIColor.black, opacity: 0.15, offSet: CGSize(width: 4.0, height: 4.0), radius: kAskFriendsButtonCornerRadius, scale: true)
        findBFFBButton.addTarget(self, action: #selector(onClickedAskFriends), for: .touchUpInside)
        
        view.addSubview(findBFFBButton)
    }
    
    @objc private func onClickedAskFriends() {
        coordinator?.askFriends()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableView.headerReuseIdentifier, for: indexPath) as! HeaderTableViewCell
            cell.bind(viewModel: viewModel.headerViewModel())
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableView.itemReuseIdentifier, for: indexPath) as! ProfileTableViewCell
        cell.bind(viewModel: viewModel.getViewModel(row: indexPath.row - 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return kBitmojiButtonSize
        }
        return kProfileCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            return
        }
        let model = viewModel.getViewModel(row: indexPath.row - 1)
        coordinator?.postFriendScoreToSnap(value: model.rawScore, friendName: model.name)
    }
    
}

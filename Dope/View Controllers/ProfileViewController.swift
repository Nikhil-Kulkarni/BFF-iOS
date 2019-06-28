//
//  ProfileViewController.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/3/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit
import SDWebImage

private let kBitmojiButtonBottomMargin: CGFloat = 20.0
private let kBitmojiButtonTopMargin: CGFloat = 12.0
private let kBitmojiButtonRightMargin: CGFloat = 12.0
private let kBitmojiButtonSize: CGFloat = 48.0
private let kAskFriendsButtonSidePadding: CGFloat = 30.0
private let kAskFriendsButtonBottomPadding: CGFloat = 28.0
private let kAskFriendsButtonHeight: CGFloat = 54.0
private let kAskFriendsButtonCornerRadius: CGFloat = 10.0
private let kProfileCellHeight: CGFloat = 51.0

class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel?
    
    private var safeArea: UIEdgeInsets!
    private var askFriendsButton: BFFButton!
    private var bitmojiButton: UIImageView!
    private var tableView: ProfileTableView!
    
    private let questionsStore = QuestionsStore.sharedInstance
    private let scoresStore = ScoresStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        
        initBitmojiButton()
        initTableView()
        initAskFriendsButton()
    }
    
    private func initBitmojiButton() {
        let x = view.frame.width - kBitmojiButtonSize - kBitmojiButtonRightMargin
        let y = safeArea.top == 0 ? kBitmojiButtonTopMargin : safeArea.top
        let frame = CGRect(x: x, y: y, width: kBitmojiButtonSize, height: kBitmojiButtonSize)
        let imageView = UIImageView(frame: frame)
        guard let bitmojiUrl = viewModel?.bitmojiUrl else {
            return
        }
        imageView.sd_setImage(with: URL(string: bitmojiUrl), completed: nil)
        
        view.addSubview(imageView)
    }
    
    private func initTableView() {
        viewModel?.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func initAskFriendsButton() {
        let screenWidth = view.frame.width
        let bottomPadding = DisplayUtils.isIphoneX() ? safeArea.bottom : kAskFriendsButtonBottomPadding
        let frame = CGRect(x: kAskFriendsButtonSidePadding, y: view.frame.height - kAskFriendsButtonHeight - bottomPadding, width: screenWidth - 2 * kAskFriendsButtonSidePadding, height: kAskFriendsButtonHeight)
        
        askFriendsButton = BFFButton(frame: frame, image: UIImage(named: "ghost"))
        askFriendsButton.backgroundColor = UIColor(red: 255/255.0, green: 252/255.0, blue: 0.0, alpha: 1.0)
        askFriendsButton.setTitle("Ask friends on Snapchat", for: .normal)
        askFriendsButton.setTitleColor(UIColor.black, for: .normal)
        askFriendsButton.titleLabel?.textAlignment = .center
        askFriendsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        askFriendsButton.roundCorners(UIRectCorner.allCorners, radius: kAskFriendsButtonCornerRadius)
        askFriendsButton.dropShadow(color: UIColor.black, opacity: 0.15, offSet: CGSize(width: 4.0, height: 4.0), radius: kAskFriendsButtonCornerRadius, scale: true)
        askFriendsButton.addTarget(self, action: #selector(onClickedAskFriends), for: .touchUpInside)
        
        view.addSubview(askFriendsButton)
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
        guard let viewModel = viewModel else {
            return 0
        }
        
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kProfileCellHeight
    }
    
}

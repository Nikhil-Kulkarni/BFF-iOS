//
//  QuestionsViewController.swift
//  Dope
//
//  Created by Nikhil Kulkarni on 6/30/19.
//  Copyright © 2019 Nikhil Kulkarni. All rights reserved.
//

import UIKit

private let kPrimaryButtonSidePadding: CGFloat = 30.0
private let kPrimaryButtonBottomPadding: CGFloat = 28.0
private let kPrimaryButtonHeight: CGFloat = 54.0
private let kPrimaryButtonCornerRadius: CGFloat = 10.0

private let kIntroLabelTextSize: CGFloat = 36.0
private let kIntroLabelPadding: CGFloat = 10.0

private let kQuestionLabelTextSize: CGFloat = 24.0
private let kQuestionLabelHeight: CGFloat = 120.0
private let kQuestionLabelTopPadding: CGFloat = 25.0

private let kTableViewTopPadding: CGFloat = 40.0
private let kTableViewCellHeight: CGFloat = 60.0

class QuestionsViewController: UIViewController {
    
    weak var coordinator: QuestionsCoordinator?
    var viewModel: QuestionsViewModel!
    private var safeArea: UIEdgeInsets?
    
    private var primaryButton: BFFButton!
    private var tableView: QuestionTableView!
    private let introLabel = UILabel()
    private let questionLabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        safeArea = UIApplication.shared.keyWindow?.safeAreaInsets
        initPrimaryButton()
        initIntroLabel()
        initQuestionLabel()
        initTableView()
        refreshPage()
        viewModel.reloadPage = {
            self.refreshPage()
        }
    }
    
    private func initPrimaryButton() {
        let screenWidth = view.frame.width
        let bottomPadding = DisplayUtils.isIphoneX() ? safeArea!.bottom : kPrimaryButtonBottomPadding
        let frame = CGRect(x: kPrimaryButtonSidePadding, y: view.frame.height - kPrimaryButtonHeight - bottomPadding, width: screenWidth - 2 * kPrimaryButtonSidePadding, height: kPrimaryButtonHeight)
        primaryButton = BFFButton(frame: frame, image: nil)
        primaryButton.titleLabel?.textAlignment = .center
        primaryButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        primaryButton.roundCorners(UIRectCorner.allCorners, radius: kPrimaryButtonCornerRadius)
        primaryButton.dropShadow(color: UIColor.black, opacity: 0.15, offSet: CGSize(width: 4.0, height: 4.0), radius: kPrimaryButtonCornerRadius, scale: true)
        primaryButton.addTarget(self, action: #selector(onPrimaryButtonClicked), for: .touchUpInside)
        view.addSubview(primaryButton)
    }
    
    private func initIntroLabel() {
        let frame = CGRect(x: kIntroLabelPadding, y: 0, width: view.frame.width - kIntroLabelPadding * 2, height: view.frame.height)
        introLabel.frame = frame
        introLabel.font = UIFont(name: "Chewy-Regular", size: kIntroLabelTextSize)
        introLabel.textAlignment = .center
        introLabel.numberOfLines = 0
        view.addSubview(introLabel)
    }
    
    private func initQuestionLabel() {
        let frame = CGRect(x: 0, y: kQuestionLabelTopPadding, width: view.frame.width, height: kQuestionLabelHeight)
        questionLabel.frame = frame
        questionLabel.font = UIFont(name: "Chewy-Regular", size: kQuestionLabelTextSize)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        view.addSubview(questionLabel)
    }
    
    private func initTableView() {
        let y = questionLabel.frame.maxY + kTableViewTopPadding
        let frame = CGRect(x: 0, y: y, width: view.frame.width, height: primaryButton.frame.minY - y)
        tableView = QuestionTableView(frame: frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func refreshPage() {
        primaryButton.alpha = 0.0
        introLabel.alpha = 0.0
        questionLabel.alpha = 0.0
        tableView.alpha = 0.0
        refreshPrimaryButton()
        refreshIntroLabel()
        refreshQuestionLabel()
        refreshTableView()
        UIView.animate(withDuration: 0.4) {
            self.primaryButton.alpha = 1.0
            self.introLabel.alpha = 1.0
            self.questionLabel.alpha = 1.0
            self.tableView.alpha = 1.0
        }
    }
    
    private func refreshPrimaryButton() {
        primaryButton.setTitle(viewModel.primaryButtonText(), for: .normal)
        primaryButton.setTitleColor(viewModel.primaryButtonTextColor(), for: .normal)
        primaryButton.backgroundColor = viewModel.primaryButtonBackgroundColor()
        primaryButton.setImage(viewModel.primaryButtonImage(), for: .normal)
    }
    
    private func refreshIntroLabel() {
        introLabel.text = viewModel.introText
    }
    
    private func refreshQuestionLabel() {
        questionLabel.text = viewModel.questionText
    }
    
    private func refreshTableView() {
        guard let _ = viewModel.cellViewModels else {
            tableView.isHidden = true
            return
        }
        
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    @objc private func onPrimaryButtonClicked() {
        viewModel.onPrimaryButtonClicked()
    }
    
}

extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellViewModels = viewModel.cellViewModels else  {
            return 0
        }
        
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableView.reuseIdentifer, for: indexPath) as! QuestionTableViewCell
        let model = viewModel.cellViewModels?[indexPath.row]
        cell.bind(viewModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onChoiceSelected(choiceIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kTableViewCellHeight
    }
}

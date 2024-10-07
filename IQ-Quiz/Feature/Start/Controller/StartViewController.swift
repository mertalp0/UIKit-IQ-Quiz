//
//  StartViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
import SnapKit
import MessageUI

final class StartViewController: BaseViewController<StartCoordinator, StartViewModel> {
    
    //MARK: - UI Elements
    private var titleLabel: UILabel = UILabel.makeAppBarLabel()
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "Hoşgeldin"
        return label
    }()
    
    private let playButton: SVCButton = {
        let button = SVCButton(type: .start)
        return button
    }()
    
    private let lastTestButton: SVCButton = {
        let button = SVCButton(type: .lastTest)
        return button
    }()
    
    private let shareButton: SVCButton = {
        let button = SVCButton(type: .share)
        return button
    }()
    
    private let feedBackButton : SVCButton = {
        let button = SVCButton(type: .feedBack)
        return button
    }()
    
    private let settingsButton : SVCButton = {
        let button = SVCButton(type: .settings)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        
    }
}

//MARK: - UI Setup and Layout
extension StartViewController {
    
    //Setup UI
    private func setupUI() {
        self.setupGradientLayer()
        
        view.addSubview(titleLabel)
        
        view.addSubview(logo)
        
        view.addSubview(welcomeLabel)
        
        view.addSubview(playButton)
        view.addSubview(lastTestButton)
        view.addSubview(shareButton)
        view.addSubview(feedBackButton)
        view.addSubview(settingsButton)
        
        playButton.delegate = self
        lastTestButton.delegate = self
        shareButton.delegate = self
        feedBackButton.delegate = self
        settingsButton.delegate = self
    }
    
    //Setup Layout
    private func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(Constants.screenHeight * 0.07)
            make.centerX.equalToSuperview()
        }
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.height.equalTo(70)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        playButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        lastTestButton.snp.makeConstraints { make in
            make.bottom.equalTo(playButton.snp.top).offset(-20)
            make.leading.equalTo(view.snp.leading).offset(50)
            make.width.height.equalTo(80)
        }
        
        shareButton.snp.makeConstraints { make in
            make.bottom.equalTo(playButton.snp.top).offset(-30)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
            make.width.height.equalTo(80)
        }
        
        feedBackButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
            make.width.height.equalTo(80)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(50)
            make.width.height.equalTo(80)
        }
    }
}

// MARK: - SVCButtonDelegate
extension StartViewController: SVCButtonDelegate {
    
    func didTapButton(_ senderType: SVCButtonType) {
        if senderType == .start {
            coordinator?.showQuiz()
        }
        else if senderType == .share {
            let appStoreLink = Constants.appStoreLink
            let activityVC = UIActivityViewController(activityItems: [appStoreLink], applicationActivities: nil)
            present(activityVC, animated: true, completion: nil)
        }
        else if senderType == .lastTest {
            coordinator?.showLastTests()
        }
        else if senderType == .feedBack {
            viewModel.sendEmail(from: self)
        }
        else if senderType == .settings {
            showSettingsBottomSheet()
        }
    }
    
    // Settings Bottom Sheet
    private func showSettingsBottomSheet() {
        let settingsActionSheet = UIAlertController(title: "Settings", message: "Change Language", preferredStyle: .actionSheet)
        
        let accountAction = UIAlertAction(title: "Türkçe", style: .default) { _ in
            print("Türkçe tapped")
            
        }
        
        let notificationsAction = UIAlertAction(title: "English", style: .default) { _ in
            print("English tapped")
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        settingsActionSheet.addAction(accountAction)
        settingsActionSheet.addAction(notificationsAction)
        settingsActionSheet.addAction(cancelAction)
        
        // iPad'de action sheet'in çökmesini önlemek için gerekli (iPad için zorunlu)
        if let popoverController = settingsActionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(settingsActionSheet, animated: true, completion: nil)
    }
}

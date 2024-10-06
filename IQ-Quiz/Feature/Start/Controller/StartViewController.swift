//
//  StartViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
import SnapKit

final class StartViewController: BaseViewController<StartCoordinator, StartViewModel> {
    
    //MARK: - UI Elements
    private var titleLabel: UILabel = UILabel.makeAppBarLabel()
    
    private var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
    
    private let storeApps : SVCButton = {
        let button = SVCButton(type: .storeApps)
        return button
    }()
    
    private let noAds : SVCButton = {
        let button = SVCButton(type: .noAds)
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
        
        view.addSubview(playButton)
        view.addSubview(lastTestButton)
        view.addSubview(shareButton)
        view.addSubview(storeApps)
        view.addSubview(noAds)

        playButton.delegate = self
        lastTestButton.delegate = self
        shareButton.delegate = self
        storeApps.delegate = self
        noAds.delegate = self
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
        
        storeApps.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
            make.width.height.equalTo(80)
        }
        
        noAds.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(50)
            make.width.height.equalTo(80)
        }

    }
}

//MARK: - SVCButtonDelegate
extension StartViewController: SVCButtonDelegate {
    func didTapButton(_ senderType: SVCButtonType) {
        if senderType == .start {
            coordinator?.showQuiz()
        }else if senderType == .share {
            print("Share Button tapped")
        }else if senderType == .lastTest {
            coordinator?.showLastTests()
        }else if senderType == .storeApps {
            print("Go to store ")
        }else if senderType == .noAds {
            print("Go to payment ")
        }
    }
}

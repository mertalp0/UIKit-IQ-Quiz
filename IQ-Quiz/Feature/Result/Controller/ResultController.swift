//
//  ResultViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
import GoogleMobileAds

final class ResultViewController: BaseViewController<ResultCoordinator, ResultViewModel>  {
    
    // MARK: - Properties
    var interstitial: GADInterstitialAd!
    var correctAnswers: Int = 0
    var iqScore: Int!
    
    // MARK: - UI Elements
    private var titleLabel: UILabel = UILabel.makeAppBarLabel()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .primaryColor
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var iqLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .secondaryColor
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var homeButton: CustomButton = {
        let button = CustomButton(title: LocalizationManager.shared.homeButtonTitle())
        return button
    }()
    
    private let applauseIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "applause")
        imageView.image = image
        return imageView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showAds()
        iqScore = IQCalculator.calculateIQ(fromCorrectAnswers: correctAnswers)
        
        setupUI()
        layout()
        
        configureUI()
        viewModel.saveResult(correctAnswers: correctAnswers, iqScore: iqScore)
    }
    private func showAds() {
        RemoteConfigManager.shared.fetchRemoteConfig { (showAds, error) in
                   if let error = error {
                       print("Remote Config Fetch Error: \(error.localizedDescription)")
                       return
                   }

                   if showAds {
                       print( "reklamlar gösteriliyor")
                       self.loadInterstitialAd()
                   } else {
                       print( "reklamlar gösterilmiyor")
                   }
               }
    }
}

// MARK: - Setup IU , Setup Layout
extension ResultViewController {
    private func setupUI() {
        self.setupBackgroundImage(a: "bg1")
        homeButton.delegate = self
    }
    
    private func layout() {
        view.addSubview(resultLabel)
        view.addSubview(titleLabel)
        view.addSubview(iqLabel)
        view.addSubview(homeButton)
        view.addSubview(applauseIcon)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(Constants.screenHeight * 0.07)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        applauseIcon.snp.makeConstraints { make in
            make.height.width.equalTo(350)
            make.center.equalToSuperview()
        }
        
        iqLabel.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(homeButton.snp.top).offset(-40)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
        }
        
        homeButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-70)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(50)
        }
    }
}

//MARK: - ConfigureUI
extension ResultViewController {
    private func configureUI() {
        let scoreText = stringManager.correctAnswersLabel(withCount: correctAnswers)
        let iqScoreText =  stringManager.iqScoreLabel(withIQScore: iqScore)
        iqLabel.text = iqScoreText
        resultLabel.text = scoreText
    }
}

// MARK: - CustomButtonDelegate
extension ResultViewController: CustomButtonDelegate{
    func buttonTapped(_ button: CustomButton) {
        coordinator?.backToRoot()
    }
}

//MARK: - GADFullScreenContentDelegate
extension ResultViewController: GADFullScreenContentDelegate{
    func loadInterstitialAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: Constants.adUnitId, request: request) { (ad, error) in
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
            self.interstitial?.fullScreenContentDelegate = self
            self.showInterstitialAd()
        }
    }
    
    func showInterstitialAd() {
        if let ad = interstitial {
            ad.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        
    }
}

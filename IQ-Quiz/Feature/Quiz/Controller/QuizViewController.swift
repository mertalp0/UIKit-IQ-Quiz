//
//  QuizController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
import GoogleMobileAds

class QuizViewController: BaseViewController<QuizCoordinator, QuizViewModel>,CustomButtonDelegate {
    
    // MARK: - Properties
    var currentQuestionIndex = 0
    var correctAnswers = 0
    var selectedOptionButton: UIButton?
    var timer: Timer?
    var totalQuizTime = 300
    var remainingTime: Int = 0
    
    //MARK: - UI Elements
    private var bannerView: GADBannerView!

    private var titleLabel: UILabel = UILabel.makeAppBarLabel()
    
    private lazy var nextButton: CustomButton = {
        let button = CustomButton(title: LocalizationManager.shared.nextButtonLabel())
        button.tintColor = .black
        button.backgroundColor = .secondaryColor
        button.delegate = self
        return button
    }()

    private var quesitonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.7
        view.layer.masksToBounds = false
        return view
    }()
    
    private var quesitonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    private var answerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var textQuestion: UILabel = {
        let label = UILabel()
        label.text = "question"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        bannerView.adUnitID = Constants.bannerAdUnitId
        addBannerViewToView(bannerView)
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        style()
        layout()
        configureUI()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
}

//MARK: - Selectors
extension QuizViewController {
    @objc func handleOptionSelected(_ sender: UIButton) {
        // Önceki seçilen butonun kenarını sıfırla
        selectedOptionButton?.layer.borderWidth = 0
        
        // Yeni seçilen butonu vurgula
        sender.layer.borderWidth = 3
        sender.layer.borderColor = UIColor.green.cgColor
        selectedOptionButton = sender
        
        // Animasyon: butonu küçük yapıp tekrar eski boyutuna döndür
        UIView.animate(withDuration: 0.1,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        })
    }
    
    func buttonTapped(_ button: CustomButton) {
        guard let selectedOptionButton = selectedOptionButton else {
            showAlert(title:  stringManager.alertTitle(), message: stringManager.alertMessage())
            return
        }
        var selectedOption = selectedOptionButton.title(for: .normal)
        if let image = selectedOptionButton.image(for: .normal),
           let imageName = image.accessibilityIdentifier{
            selectedOption = imageName
        }
        if selectedOption == viewModel.questions[currentQuestionIndex].correctAnswer {
            correctAnswers += 1
        }
        currentQuestionIndex += 1
        if currentQuestionIndex < viewModel.questions.count {
            configureUI()
        } else {
            nextButton.setTitle(stringManager.finishButtonLabel(), for: .normal)
            showResult()
        }
        self.selectedOptionButton = nil
    }
    
    private func showResult() {
        
        coordinator?.showResult(correctAnswers:correctAnswers)
    }
}

//MARK: - Helpers
extension QuizViewController{
    func style() {
        self.setupBackgroundImage(a: "bg2")
    }
    
    func layout() {
        view.addSubview(titleLabel)
        view.addSubview(timerLabel)
        view.addSubview(quesitonContainerView)
        view.addSubview(answerView)
        view.addSubview(nextButton)
        view.addSubview(bannerView)
        quesitonContainerView.addSubview(quesitonStackView)
     
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        quesitonContainerView.translatesAutoresizingMaskIntoConstraints = false
        answerView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        quesitonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.screenHeight * 0.07),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            timerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            quesitonContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30),
            quesitonContainerView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 15),
            quesitonContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            quesitonContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            quesitonStackView.topAnchor.constraint(equalTo: quesitonContainerView.topAnchor, constant: 10),
            quesitonStackView.leadingAnchor.constraint(equalTo: quesitonContainerView.leadingAnchor, constant: 10),
            quesitonStackView.trailingAnchor.constraint(equalTo: quesitonContainerView.trailingAnchor, constant: -10),
            quesitonStackView.bottomAnchor.constraint(equalTo: quesitonContainerView.bottomAnchor, constant: -10),
            
            answerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.73),
            answerView.topAnchor.constraint(equalTo: quesitonContainerView.bottomAnchor, constant: Constants.screenHeight * 0.05),
            answerView.bottomAnchor.constraint(equalTo: nextButton.topAnchor,constant: 5),
            
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.bottomAnchor.constraint(equalTo: bannerView.topAnchor, constant: -23),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
            
            bannerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: - ConfigureUI
extension QuizViewController {
    func configureUI() {
        // Clear previous views
        answerView.subviews.forEach { $0.removeFromSuperview() }
        quesitonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Update question text
        textQuestion.text = viewModel.questions[currentQuestionIndex].questionText
        
        // Add question image if available
        if let questionImageName = viewModel.questions[currentQuestionIndex].questionImage,
           let questionImage = UIImage(named: questionImageName) {
            
            let imageView = UIImageView(image: questionImage)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            quesitonStackView.addArrangedSubview(imageView)
            
            // Set a height for the image
            imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        }
        quesitonStackView.addArrangedSubview(textQuestion)
        let options = viewModel.questions[currentQuestionIndex].options
        answerView.subviews.forEach { $0.removeFromSuperview() }
        
        let columns = 2
        let spacing: CGFloat = 8
        let buttonSize = CGFloat(Constants.screenHeight * 0.15)
        
        for (index, option) in options.enumerated() {
            if viewModel.questions[currentQuestionIndex].type == .imageAnswer {
                let optionButton = UIButton()
                let imageName = option
                let image = UIImage(named: imageName)
                image?.accessibilityIdentifier = option
                optionButton.setImage(image, for: .normal)
                optionButton.imageView?.contentMode = .scaleAspectFill
                optionButton.layer.cornerRadius = 8
                optionButton.backgroundColor = .white
                optionButton.clipsToBounds = true
                optionButton.addTarget(self, action: #selector(handleOptionSelected(_:)), for: .touchUpInside)
                
                
                let padding: CGFloat = 2
                optionButton.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
                optionButton.imageEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
                
                answerView.addSubview(optionButton)
                optionButton.translatesAutoresizingMaskIntoConstraints = false
                
                let row = index / columns
                let column = index % columns
                
                NSLayoutConstraint.activate([
                    optionButton.leadingAnchor.constraint(equalTo: answerView.leadingAnchor, constant: CGFloat(column) * (buttonSize + spacing) + spacing),
                    optionButton.topAnchor.constraint(equalTo: answerView.topAnchor, constant: CGFloat(row) * (buttonSize + spacing)),
                    optionButton.widthAnchor.constraint(equalToConstant: buttonSize),
                    optionButton.heightAnchor.constraint(equalToConstant: buttonSize)
                ])
                
            } else {
                // Text Answer için mevcut olan kod
                let optionButton = UIButton()
                optionButton.setTitle(option, for: .normal)
                optionButton.backgroundColor = .primaryColor
                optionButton.layer.cornerRadius = 8
                optionButton.addTarget(self, action: #selector(handleOptionSelected(_:)), for: .touchUpInside)
                answerView.addSubview(optionButton)
                optionButton.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    optionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
                    optionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
                    optionButton.heightAnchor.constraint(equalToConstant: Constants.screenHeight * 0.07),
                    optionButton.topAnchor.constraint(equalTo: answerView.topAnchor, constant: CGFloat(Constants.screenHeight * 0.15) * 0.5 * CGFloat(index))                ])
            }
        }
    }
}

//MARK: - Timer
extension QuizViewController {
    // MARK: - Timer
    func startTimer() {
        remainingTime = totalQuizTime 
        updateTimerLabel()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        remainingTime -= 1
        updateTimerLabel()
        
        if remainingTime <= 0 {
            timer?.invalidate()
            showResult()
        }
    }
    func updateTimerLabel() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
}

//MARK: - Setup Banner , GADBannerViewDelegate
extension QuizViewController : GADBannerViewDelegate {
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    
}

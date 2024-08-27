//
//  QuizController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit

class QuizViewController: BaseViewController<QuizCoordinator, QuizViewModel> {
    // MARK: - Properties
    var currentQuestionIndex = 0
    var correctAnswers = 0
    var selectedOptionButton: UIButton?
    var timer: Timer?
    var totalQuizTime = 300// 5 dakika (300 saniye)
    var remainingTime: Int = 0
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "IQTest"
        label.textColor = UIColor(hex: "#48BFE3")
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("İleri", for: .normal)
        button.backgroundColor = UIColor(hex: "#48BFE3")
        button.tintColor = .black
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
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
        stackView.spacing = 10
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
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium) // Yazı tipi ve boyutu
        label.textAlignment = .center
        label.numberOfLines = 0 // Sınırsız satıra yayılabilir
        label.lineBreakMode = .byWordWrapping // Kelime // Auto Layout ile uyumlu olması için
        
        return label
    }()
    private var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        configureUI()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate() // Zamanlayıcıyı iptal edin
    }
    
    // MARK: - Timer
    func startTimer() {
        remainingTime = totalQuizTime // Toplam süreyi ayarla
        updateTimerLabel()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        remainingTime -= 1
        updateTimerLabel()
        
        if remainingTime <= 0 {
            timer?.invalidate()
            showResult() // Zamanlayıcı bitince sonucu göster
        }
    }
    
    func updateTimerLabel() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func resetTimer() {
        timer?.invalidate() // Zamanlayıcıyı iptal edin
        startTimer() // Yeni bir zamanlayıcı başlatın
    }
    
    // MARK: - Helpers
    func style() {
        self.setupGradientLayer()
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
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            timerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
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
            answerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40),
            answerView.topAnchor.constraint(equalTo: quesitonContainerView.bottomAnchor, constant: 40),
            
            
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
        
        // Add question text
        quesitonStackView.addArrangedSubview(textQuestion)
        
        // Add answer options
        let options = viewModel.questions[currentQuestionIndex].options
        
        // Mevcut alt görünümleri temizleyelim
        answerView.subviews.forEach { $0.removeFromSuperview() }
        
        let columns = 2
        let spacing: CGFloat = 16
        // Buton boyutunu biraz küçültelim
        let buttonSize = (UIScreen.main.bounds.width - (CGFloat(columns + 1) * spacing)) / CGFloat(columns) * 0.7 // %80 boyutta
        
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
                
                
                let padding: CGFloat = 8
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
                optionButton.backgroundColor = UIColor(hex: "#5A189A")
                optionButton.layer.cornerRadius = 8
                optionButton.addTarget(self, action: #selector(handleOptionSelected(_:)), for: .touchUpInside)
                answerView.addSubview(optionButton)
                optionButton.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    optionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
                    optionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
                    optionButton.heightAnchor.constraint(equalToConstant: 60),
                    optionButton.topAnchor.constraint(equalTo: answerView.topAnchor, constant: CGFloat(70 * index))
                ])
            }
        }
    }
}

// MARK: - Selectors
extension QuizViewController {
    @objc func handleNextButton(_ sender: UIButton) {
        
        animateButton(sender)
        
        guard let selectedOptionButton = selectedOptionButton else {
            showAlert(title:  "Uyarı", message: "Lütfen bir seçenek seçin")
            return
        }
        
        var selectedOption = selectedOptionButton.title(for: .normal)
        
        if let image = selectedOptionButton.image(for: .normal),
           let imageName = image.accessibilityIdentifier{
            print("Image Name: \(imageName)")
            selectedOption = imageName
        } else {
            print("Image is not set or has no name")
        }
        
        
        if selectedOption == viewModel.questions[currentQuestionIndex].correctAnswer {
            correctAnswers += 1
        }
        
        currentQuestionIndex += 1
        if currentQuestionIndex < viewModel.questions.count {
            configureUI()
        } else {
            nextButton.setTitle("Finish", for: .normal)
            showResult()
        }
        self.selectedOptionButton = nil
    }
    
    func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { finish in
            UIView.animate(withDuration: 0.1, animations: {
                button.transform = CGAffineTransform.identity
            })
        })
    }
    
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
    
    func showResult() {
        coordinator?.showResult(correctAnswers:correctAnswers)
    }
}

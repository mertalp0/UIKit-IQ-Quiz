//
//  ResultViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import UIKit

class ResultViewController: BaseViewController<ResultCoordinator, ResultViewModel>, CustomButtonDelegate  {
    // MARK: - Properties
    private var titleLabel: UILabel = UILabel.makeAppBarLabel()
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Result"
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
        label.text = "iq label"
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
        let button = CustomButton(title: "Ana Sayfa")
        return button
    }()
    
  
    var correctAnswers: Int = 0
    var iqScore: Int!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        iqScore = IQCalculator.calculateIQ(fromCorrectAnswers: correctAnswers)
        setupUI()
        layout()
        homeButton.delegate = self
        configureUI()
        viewModel.saveResult(correctAnswers: correctAnswers, iqScore: iqScore)
    }
}

//MARK: - Helpers
extension ResultViewController{
    private func setupUI() {
        self.setupGradientLayer()
    }
    
    private func layout(){
        view.addSubview(resultLabel)
        view.addSubview(titleLabel)
        view.addSubview(iqLabel)
        view.addSubview(homeButton)
       
        
      
        iqLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        homeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.screenHeight * 0.07),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
            resultLabel.heightAnchor.constraint(equalToConstant: 100),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            iqLabel.heightAnchor.constraint(equalToConstant: 80),
            iqLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iqLabel.bottomAnchor.constraint(equalTo: homeButton.topAnchor, constant: -40),
            iqLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            iqLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            homeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            homeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

//MARK: - ConfigureUI
extension ResultViewController {
    private func configureUI() {
        let scoreText = "Tebrikler!!\n15 Sorudan \(correctAnswers) doğru yaptınız.."
        let iqScoreText = "IQ Test Sonucunuz: \(iqScore ?? 0) IQ"
        iqLabel.text = iqScoreText
        resultLabel.text = scoreText
    }
}

// MARK: - CustomButtonDelegate
extension ResultViewController {
    func buttonTapped(_ button: CustomButton) {
        coordinator?.backToRoot()
    }
}

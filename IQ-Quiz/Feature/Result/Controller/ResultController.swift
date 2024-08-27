//
//  ResultViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import UIKit

class ResultViewController: BaseViewController<ResultCoordinator, ResultViewModel> {
    // MARK: - Properties
  
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "IQTest"
        label.textColor = UIColor(hex: "#48BFE3")
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Result"
        label.backgroundColor = .systemIndigo
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var iqLabel: UILabel = {
        let label = UILabel()
        label.text = "iq"
        label.backgroundColor = UIColor(hex: "#48BFE3")
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ana Sayfa", for: .normal)
        button.backgroundColor = .systemIndigo
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    private var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo") // Burada logo resminizin adını belirtin
        imageView.contentMode = .scaleAspectFit // Resmi orantılı olarak ölçeklendirir
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var correctAnswers: Int = 0
    var iqScore: Int!
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        iqScore = IQCalculator.calculateIQ(fromCorrectAnswers: correctAnswers)
        setupUI()
        viewModel.saveResult(correctAnswers: correctAnswers, iqScore: iqScore)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateLogo()
    }
    private func setupUI() {
        self.setupGradientLayer()
        view.addSubview(resultLabel)
        view.addSubview(titleLabel)
        view.addSubview(iqLabel)
        view.addSubview(backButton)
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
      
            resultLabel.heightAnchor.constraint(equalToConstant: 100),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logo.widthAnchor.constraint(equalToConstant: 350), // Genişlik
            logo.heightAnchor.constraint(equalToConstant: 350) , // Yükseklik
            
            
            iqLabel.heightAnchor.constraint(equalToConstant: 80),
            iqLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iqLabel.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -40),
            iqLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            iqLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        configureUI()
    }
    
    private func configureUI() {
        let scoreText = "Tebrikler!!\n15 Sorudan \(correctAnswers) doğru yaptınız.."
        let iqScoreText = "IQ Test Sonucunuz: \(iqScore ?? 0) IQ"
        iqLabel.text = iqScoreText
        resultLabel.text = scoreText
    }
    
    @objc private func handleBackButton() {
        coordinator?.backToRoot()
    }
}

//MARK: - Animation
extension ResultViewController {
    private func animateLogo() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 3.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
       
        let startPosition = CGPoint(x: view.center.x, y: view.center.y + -25 )
        let endPosition = CGPoint(x: view.center.x, y: view.center.y + 20)
       
        animation.fromValue = NSValue(cgPoint: startPosition)
        animation.toValue = NSValue(cgPoint: endPosition)
        
        logo.layer.add(animation, forKey: "positionAnimation")
    }
}

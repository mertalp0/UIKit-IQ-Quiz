//
//  StartViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import UIKit

class StartViewController: BaseViewController<StartCoordinator, StartViewModel>, CustomButtonDelegate {
    //MARK: - Properties
    private var titleLabel: UILabel = UILabel.makeAppBarLabel()

    private let animatedLogoView: AnimatedLogoView = {
        let view = AnimatedLogoView()
        return view
    }()
    
    private lazy var startButton: CustomButton = {
        let button = CustomButton(title: "Başla")
        button.delegate = self
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - Helpers
extension StartViewController{
    func style() {
        self.setupGradientLayer()
    }
    
    func layout() {
        view.addSubview(titleLabel)
        view.addSubview(animatedLogoView)
        view.addSubview(startButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        animatedLogoView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.screenHeight * 0.05),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            animatedLogoView.widthAnchor.constraint(equalToConstant: 350),
            animatedLogoView.heightAnchor.constraint(equalToConstant: 350) ,
            animatedLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animatedLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
        ])
    }
}

//MARK: - CustomButtonDelegate
extension StartViewController {
    func buttonTapped(_ button: CustomButton) {
        coordinator?.showQuiz()
    }
}

//
//  StartViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import UIKit

class StartViewController: BaseViewController<StartCoordinator, StartViewModel> {
    //MARK: - Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "IQTest"
        label.textColor = UIColor(hex: "#48BFE3")
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo") // Burada logo resminizin adını belirtin
        imageView.contentMode = .scaleAspectFit // Resmi orantılı olarak ölçeklendirir
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Başla", for: .normal)
        button.backgroundColor = UIColor(hex: "5A189A")
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.addTarget(nil, action: #selector(handleStartButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        animateLogo()
    }
    override func viewWillAppear(_ animated: Bool) {
        animateLogo()
    }
    
    func style() {
        self.setupGradientLayer()
    }
    
    func layout() {
        view.addSubview(titleLabel)
        view.addSubview(startButton)
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            logo.widthAnchor.constraint(equalToConstant: 350), // Genişlik
            logo.heightAnchor.constraint(equalToConstant: 350) , // Yükseklik
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
        ])
    }
    // MARK: - Animation
     private func animateLogo() {
         let animation = CABasicAnimation(keyPath: "position")
         animation.duration = 3.0
         animation.repeatCount = .infinity
         animation.autoreverses = true
        
         let startPosition = CGPoint(x: view.center.x, y: view.center.y + 15 )
         let endPosition = CGPoint(x: view.center.x, y: view.center.y + 60)
        
         animation.fromValue = NSValue(cgPoint: startPosition)
         animation.toValue = NSValue(cgPoint: endPosition)
         
         logo.layer.add(animation, forKey: "positionAnimation")
     }
}

//MARK: - Selectors
extension StartViewController {
    @objc func handleStartButton(_ sender: UIButton) {
        animateButton(sender)
        coordinator?.showQuiz()
        
    }

    func animateButton(_ button: UIButton) {
            UIView.animate(withDuration: 0.1,
                           animations: {
                            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                           },
                           completion: { finish in
                            UIView.animate(withDuration: 0.1, animations: {
                                button.transform = CGAffineTransform.identity
                            })
                })
        }
}

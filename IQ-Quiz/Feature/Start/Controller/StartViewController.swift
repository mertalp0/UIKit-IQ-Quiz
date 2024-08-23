import UIKit

class StartViewController: BaseViewController<StartCoordinator, StartViewModel> {
    //MARK: - Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start View"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
        
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
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
    }
    
    func style() {
        self.setupGradientLayer()
    }
    
    func layout() {
        view.addSubview(titleLabel)
        view.addSubview(startButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
        ])
    }
}

//MARK: - Selectors
extension StartViewController {
    @objc func handleStartButton() {
        coordinator?.showQuiz()
        
    }
}

//
//  QuizController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
class QuizViewController : BaseViewController <QuizCoordinator, QuizViewModel>{
    //MARK: - Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Quiz View"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
  

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - Helpers
extension QuizViewController {
    func style() {
        view.backgroundColor = .white
    }
    
    func layout() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
          ])
    }
}

//MARK: - Selectors
extension QuizViewController {

}

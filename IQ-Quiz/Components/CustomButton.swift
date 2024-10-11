//
//  CustomButton.swift
//  IQ-Quiz
//
//  Created by mert alp on 27.08.2024.
//
import UIKit

protocol CustomButtonDelegate : AnyObject {
    func buttonTapped(_ button : CustomButton )
}

class CustomButton : UIButton {
    //MARK: - Properties
    weak var delegate : CustomButtonDelegate?
    var title : String
    
    //MARK: - Lifecycle
    init(title : String ) {
        self.title = title
        super.init(frame: .zero)
        setupUI()
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)  

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SetupUI
extension CustomButton {
    private func setupUI() {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .primaryColor
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    }
}

//MARK: - Animations
extension CustomButton {
    private func animateButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}

//MARK: - Selectors
extension CustomButton {
   @objc func handleTap(){
        animateButton()
        delegate?.buttonTapped(self)
    }
}


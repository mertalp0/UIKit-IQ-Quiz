//
//  AnimatedLogo.swift
//  IQ-Quiz
//
//  Created by mert alp on 27.08.2024.
//
import UIKit

class AnimatedLogoView: UIView {
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
      //animate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
      //animate()
    }
}

//MARK: - SetupUI
extension AnimatedLogoView{
    private func setupUI(){
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 350),
            logo.heightAnchor.constraint(equalToConstant: 350),
    
        ])
    }
}

//MARK: - Animation
extension AnimatedLogoView{
     func animate(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 3.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
        
        let startPosition = CGPoint(x: center.x, y: center.y + 15)
        let endPosition = CGPoint(x: center.x, y: center.y + 60)
        
        animation.fromValue = NSValue(cgPoint: startPosition)
        animation.toValue = NSValue(cgPoint: endPosition)
        
        logo.layer.add(animation, forKey: "positionAnimation")
    }
}

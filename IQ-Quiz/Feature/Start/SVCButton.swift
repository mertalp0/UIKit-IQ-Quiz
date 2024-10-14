//
//  SVCButton.swift
//  IQ-Quiz
//
//  Created by mert alp on 4.10.2024.
//
//
import UIKit
import SnapKit

protocol SVCButtonDelegate: AnyObject {
    func didTapButton(_ senderType: SVCButtonType)
}

enum SVCButtonType {
    case start
    case share
    case lastTest
    case feedBack
    case settings
    
    var icon: UIImage? {
        switch self {
        case .start:
            return UIImage(systemName: "play.fill")
        case .share:
            return UIImage(systemName: "square.and.arrow.up.fill")
        case .lastTest:
            return UIImage(systemName: "list.bullet.clipboard.fill")
        case .feedBack:
            return UIImage(systemName: "apple.logo")
        case .settings:
            return UIImage(systemName: "gearshape")
        }
    }
}

final class SVCButton: UIView {
    
    weak var delegate: SVCButtonDelegate?
    
    private let iconImageView: UIImageView = UIImageView()
    private let button: UIButton = UIButton(type: .custom)
    private var iconSize: Int!
    private var type : SVCButtonType
    
    init(type: SVCButtonType) {
        self.type = type
        super.init(frame: .zero)
        self.iconImageView.image = type.icon
        self.iconSize = type == .start ? 60 : 35
        setupView()
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        button.backgroundColor = .primaryColor
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        
        button.layer.borderColor = UIColor(red: 36/255, green: 76/255, blue: 121/255, alpha: 0.5).cgColor
        button.layer.borderWidth = 8
        
        button.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5).cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 3)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 5
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
    
        addSubview(button)
        button.addSubview(iconImageView)
    }
    
    private func setupLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(iconSize)
        }
    }
    
    private func setupActions() {
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
    }}

// MARK: - Selectors
extension SVCButton {
    @objc private func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }

    @objc private func buttonTouchUp(_ sender: UIButton) {
    
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform.identity
        }) { _ in
            self.delegate?.didTapButton(self.type)
        }
    }
}

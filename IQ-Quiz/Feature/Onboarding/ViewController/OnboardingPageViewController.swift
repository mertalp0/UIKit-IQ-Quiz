//
//  OnboardingPageViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 12.10.2024.
//
import UIKit
import SnapKit

protocol OnboardingPageDelegate: AnyObject {
    func didTapNextButton(on page: OnboardingPageViewController)
}

class OnboardingPageViewController: UIViewController {
    
    // UI bileşenleri
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()
    
    weak var delegate: OnboardingPageDelegate?
    
    init(imageName: String, title: String, text: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.imageView.image = UIImage(named: imageName)
        self.titleLabel.text = title
        self.descriptionLabel.text = text
        self.button.setTitle(buttonTitle, for: .normal)
        self.view.backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(button)
        
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
      
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapNextButton(on: self)
    }
}

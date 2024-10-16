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

final class OnboardingPageViewController: BaseViewController<OnboardingCoordinator,OnboardingViewModel> {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()
    
    weak var delegate: OnboardingPageDelegate?
    
    init(imageName: ImageManager.AppImages, title: String, text: String, buttonTitle: String) {
        self.imageView.image = ImageManager.shared.getImage(for: imageName)
        self.titleLabel.text = title
        self.descriptionLabel.text = text
        self.button.setTitle(buttonTitle, for: .normal)
        super.init(viewModel: OnboardingViewModel())
    }
    
    required init?(coder: NSCoder) {
          super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupLayout()
        self.setupBackgroundImage(withImage: .backgroundThree )
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(button)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
      
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primaryColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.screenWidth * 0.1)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(button.snp.top)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-70)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapNextButton(on: self)
    }
}

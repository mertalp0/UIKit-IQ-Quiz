//
//  LatestTestsController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import UIKit
import SnapKit

class LatestTestsController: BaseViewController<LatestTestsCoordinator, LatestTestsViewModel> {
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel.makeAppBarLabel()
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        let icon = UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24)) // İkonun boyutunu artır
        button.setImage(icon, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.isHidden = true // Başlangıçta gizli olmalı
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let latestTestLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupTableView()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchLatestTests()
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
    }
}

// MARK: - Setup UI and Setup Layout
extension LatestTestsController {
    
    // Setup UI
    private func setupUI() {
        self.setupBackgroundImage(withImage: .backgroundThree  )
        latestTestLabel.text = stringManager.latestTestLabel()
        emptyStateLabel.text = stringManager.emptyStateLabel()
    }
    
    // Setup Layout
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(latestTestLabel)
        view.addSubview(tableView)
        view.addSubview(backButton)
        view.addSubview(emptyStateLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(Constants.screenHeight * 0.06)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(16)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(Constants.screenHeight * 0.06)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(44) 
        }
        
        latestTestLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(latestTestLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        emptyStateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Setup Table View
extension LatestTestsController {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LatestTestCell.self, forCellReuseIdentifier: "LatestTestCell")
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
    }
}

// MARK: - UITableViewDelegate , UITableViewDataSource
extension LatestTestsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.latestTests.count
        
        emptyStateLabel.isHidden = count != 0
        tableView.isHidden = count == 0
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LatestTestCell", for: indexPath) as? LatestTestCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.latestTests[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Selectors
extension LatestTestsController {
    
    @objc private func handleBackButton() {
        coordinator?.dismiss()
    }
}

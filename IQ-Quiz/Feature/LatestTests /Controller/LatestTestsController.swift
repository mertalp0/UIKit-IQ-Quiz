//
//  LatestTestsController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import UIKit

class LatestTestsController: BaseViewController<LatestTestsCoordinator, LatestTestsViewModel> {
    // MARK: - Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "IQTest"
        label.textColor = UIColor(hex: "#48BFE3")
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none // Remove default separator
        return tableView
    }()
    
    private var latestTestLabel: UILabel = {
        let label = UILabel()
        label.text = "Son Testler"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchLatestTests()
        tableView.reloadData()
    }
    
    private func style() {
        self.setupGradientLayer()
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(latestTestLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            latestTestLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            latestTestLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: latestTestLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register custom cell
        tableView.register(LatestTestCell.self, forCellReuseIdentifier: "LatestTestCell")
        
        // Set separator inset and layout margins
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
    }
}

extension LatestTestsController: UITableViewDelegate, UITableViewDataSource {
    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.latestTests.count
    }
    
    // Cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LatestTestCell", for: indexPath) as? LatestTestCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.latestTests[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}

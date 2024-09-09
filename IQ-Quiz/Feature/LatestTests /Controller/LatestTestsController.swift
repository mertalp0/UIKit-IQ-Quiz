//
//  LatestTestsController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import UIKit

class LatestTestsController: BaseViewController<LatestTestsCoordinator, LatestTestsViewModel> {
    // MARK: - Properties
    private var titleLabel: UILabel = UILabel.makeAppBarLabel()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var latestTestLabel: UILabel = {
        let label = UILabel()
        label.text = "Son Testler"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
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
}

//MARK: - Helpers
extension LatestTestsController{
    private func style() {
        self.setupGradientLayer()
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(latestTestLabel)
        view.addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        latestTestLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.screenHeight * 0.05),
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
}

//MARK: - Setup Table View
extension LatestTestsController{
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LatestTestCell.self, forCellReuseIdentifier: "LatestTestCell")
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
    }
}

//MARK: - UITableViewDelegate , UITableViewDataSource
extension LatestTestsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.latestTests.count
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

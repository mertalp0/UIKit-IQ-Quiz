//
//  LatestTestsCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation

class LatestTestsCoordinator : BaseCoordinator {
    override func start() {
        let latestTestsViewModel = LatestTestsViewModel()
        let latestTestsViewController = LatestTestsController(viewModel : latestTestsViewModel)
        latestTestsViewController.coordinator = self
        hideBackButton(for: latestTestsViewController)
        navigationController.pushViewController( latestTestsViewController, animated: true)
    }
    
}

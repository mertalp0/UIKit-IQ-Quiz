//
//  TabBarCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import Foundation
import UIKit

class TabBarCoordinator: BaseCoordinator {
    
    private let startCoordinator = StartCoordinator(navigationController: UINavigationController())
  //private let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    private let latestTestCoordinator = LatestTestsCoordinator(navigationController: UINavigationController())
    override func start() {
        let tabBarController = TabBarControllerFactory.createTabBarController(
            latestTestCoordinator : latestTestCoordinator,
            startCoordinator: startCoordinator
           // profileCoordinator: profileCoordinator
        )
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}

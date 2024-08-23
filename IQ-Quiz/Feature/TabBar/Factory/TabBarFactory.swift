//
//  TabBarFactory.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit

struct TabBarControllerFactory {
    
    static func createTabBarController(
        latestTestCoordinator : LatestTestsCoordinator,
        startCoordinator: StartCoordinator,
        profileCoordinator: ProfileCoordinator
        
    ) -> UITabBarController {
        
        // Setup Profile Coordinator
        latestTestCoordinator.start()
        let latestTestNavigationController = latestTestCoordinator.navigationController
        latestTestNavigationController.tabBarItem = UITabBarItem(title: "Tests", image: UIImage(systemName: "checkmark.gobackward"), tag: 1)
        // Setup Home Coordinator
        startCoordinator.start()
        let startNavigationController = startCoordinator.navigationController
        startNavigationController.tabBarItem = UITabBarItem(title: "Start", image: UIImage(systemName: "brain.fill"), tag: 0)
        
        // Setup Profile Coordinator
        profileCoordinator.start()
        let profileNavigationController = profileCoordinator.navigationController
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 1)
        
        // Create Tab Bar Controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [latestTestNavigationController,startNavigationController, profileNavigationController]
        tabBarController.selectedIndex = 1
        
        tabBarController.tabBar.tintColor = UIColor(hex: "5A189A")
        tabBarController.tabBar.backgroundColor = UIColor(hex: "48BFE3").withAlphaComponent(0.9)
        tabBarController.tabBar.isTranslucent = false
        
        return tabBarController
    }
}

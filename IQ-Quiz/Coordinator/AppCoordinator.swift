//
//  AppCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
class AppCoordinator : BaseCoordinator {
    override func start() {
        let startCoordinator = TabBarCoordinator(navigationController : navigationController)
            startCoordinator.start()
    }
  
}

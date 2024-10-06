//
//  StartCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation

class StartCoordinator : BaseCoordinator {
    override func start() {
         let startViewModel = StartViewModel()
         let startViewController = StartViewController(viewModel: startViewModel)
         startViewController.coordinator = self
         navigationController.setViewControllers([startViewController], animated: true)
     }
    func showQuiz(){
        let quizCoordinator = QuizCoordinator(navigationController: navigationController)
        quizCoordinator.start()
    }
    func showLastTests(){
        let coordinator = LatestTestsCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}

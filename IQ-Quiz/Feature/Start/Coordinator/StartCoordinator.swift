//
//  StartCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation

class StartCoordinator : BaseCoordinator {
    override func start() {
        addChild(self)
         let startViewModel = StartViewModel()
         let startViewController = StartViewController(viewModel: startViewModel)
         startViewController.coordinator = self
         navigationController.pushViewController(startViewController, animated: true)
     }
    func showQuiz(){
        let quizCoordinator = QuizCoordinator(navigationController: navigationController)
        quizCoordinator.start()
    }
}

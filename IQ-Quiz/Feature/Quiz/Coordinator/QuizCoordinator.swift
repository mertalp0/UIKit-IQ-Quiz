//
//  QuizCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation
class QuizCoordinator : BaseCoordinator {
    override func start() {
        let quizViewModel = QuizViewModel()
        let quizViewController = QuizViewController(viewModel: quizViewModel)
        quizViewController.coordinator = self
        hideBackButton(for: quizViewController)
        quizViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(quizViewController, animated: true)
     }
    func showResult(correctAnswers:Int){
        let resultCoordinator = ResultCoordinator(navigationController: navigationController)
        resultCoordinator.correctAnswers = correctAnswers
        resultCoordinator.start()
    }

}

//
//  ResultCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 23.08.2024.
//

import Foundation
class ResultCoordinator : BaseCoordinator {
    var correctAnswers: Int = 0
    override func start() {
        let resultViewModel = ResultViewModel()
        let resultViewController = ResultViewController(viewModel: resultViewModel)
        resultViewController.correctAnswers = correctAnswers
        resultViewController.coordinator = self
        hideBackButton(for: resultViewController)
        resultViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(resultViewController, animated: true)
     }
   func backToRoot(){
       navigationController.popToRootViewController(animated: true)
   }
}

//
//  AppCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
class AppCoordinator : BaseCoordinator {
   
    override func start() {
           if !hasSeenOnboarding() {
               let onboardingCoordinator = OnboardingCoordinator(navigationController: self.navigationController)
                    onboardingCoordinator.start()
           } else {
               let startCoordinator = StartCoordinator(navigationController: self.navigationController)
                   startCoordinator.start()
           }
       }
    func startQuiz() {
       let quizCoordinator = QuizCoordinator(navigationController : navigationController)
        quizCoordinator.start()
   }

    private func hasSeenOnboarding() -> Bool {
           return UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
       }
}

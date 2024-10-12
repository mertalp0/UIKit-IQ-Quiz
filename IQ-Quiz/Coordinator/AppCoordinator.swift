//
//  AppCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
class AppCoordinator : BaseCoordinator {
    
    override func start() {
        if hasSeenOnboarding() {
            let startCoordinator = StartCoordinator(navigationController: self.navigationController)
            startCoordinator.start()
            
        } else {
            let onboardingCoordinator = OnboardingCoordinator(navigationController: self.navigationController)
            onboardingCoordinator.start()
        }
    }
    func startQuiz() {
        let quizCoordinator = QuizCoordinator(navigationController : navigationController)
        quizCoordinator.start()
    }
    
    private func hasSeenOnboarding() -> Bool {
        let hasSeenOnBoarding =  UserDefaultsManager.shared.hasSeenOnboarding()
        return hasSeenOnBoarding
        
    }
}

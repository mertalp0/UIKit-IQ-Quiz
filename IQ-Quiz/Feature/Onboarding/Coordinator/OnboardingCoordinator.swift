//
//  OnboardingCoordinator.swift
//  IQ-Quiz
//
//  Created by mert alp on 12.10.2024.
//

class OnboardingCoordinator : BaseCoordinator {
 
    override func start() {
        let viewModel = OnboardingViewModel()
        let onboardingController = OnboardingViewController(viewModel: viewModel)
        onboardingController.coordinator = self
        hideBackButton(for: onboardingController)
        navigationController.pushViewController(onboardingController, animated: true)
    }
    
    func showStart(){
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        startCoordinator.start()
    }
}

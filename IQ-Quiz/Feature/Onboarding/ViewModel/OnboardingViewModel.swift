//
//  OnboardingViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 12.10.2024.
//
import UIKit

class OnboardingViewModel : BaseViewModel {
    
    func onboardingTrue(){
        UserDefaultsManager.shared.setOnboardingComplete()
    }
}

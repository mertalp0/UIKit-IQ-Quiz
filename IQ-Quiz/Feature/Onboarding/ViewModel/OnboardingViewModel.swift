//
//  OnboardingViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 12.10.2024.
//
import UIKit

class OnboardingViewModel : BaseViewModel {
    
    func onboardingTrue(){
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        UserDefaults.standard.synchronize()
    }
}

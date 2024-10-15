//
//  ImageManager.swift
//  IQ-Quiz
//
//  Created by mert alp on 14.10.2024.
//


import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    enum AppIcons: String {
        case play = "play.fill"
        case share = "square.and.arrow.up.fill"
        case list = "list.bullet.circle.fill"
        case languageSettings = "globe"
        case mail = "envelope.fill"
        case back = "chevron.backward"
    }
   
    func getImage(named name: AppIcons) -> UIImage? {
        return UIImage(systemName: name.rawValue)
    }
    
    
    enum AppImages: String {
        
        case applause = "applause"
        case backgroundOne = "background_one"
        case backgroundTwo = "background_two"
        case backgroundThree = "background_three"
        case launch = "launch"
        case onboardingOne = "Leonardo_Phoenix_A_brain_vector_intricately_detailed_with_swir_1"
        case onboardingFour = "Leonardo_Phoenix_A_brain_vector_intricately_detailed_with_swir_2"
        case onboardingTwo = "Leonardo_Phoenix_A_stunning_digital_illustration_featuring_a_b_0"
        case onboardingThree = "Leonardo_Phoenix_A_stunning_digital_illustration_featuring_a_b_1"
        case logo = "logo"
        case logoTwo = "logo_two"
        
    }
    
    func getImage(for image: AppImages) -> UIImage? {
        return UIImage(named: image.rawValue)
    }
}


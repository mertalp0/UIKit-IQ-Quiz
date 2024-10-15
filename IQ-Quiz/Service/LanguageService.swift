//
//  LanguageService.swift
//  IQ-Quiz
//
//  Created by mert alp on 7.10.2024.
//

import Foundation

final class LanguageService {
    
    enum LanguageCode : String {
        case english = "en"
        case turkish = "tr"
        case spanish = "es"
        case german = "de"
        
        
        var jsonFileName: String {
            switch self {
            case .english:
                return "questions_en"
            case .turkish:
                return "questions_tr"
            case .spanish:
                return "questions_es"
            case .german:
                return "questions_de"
            }
        }
    }
    
    static func currentLanguage() -> String {
        
        let currentLanguage = UserDefaultsManager.shared.getCurrentLanguage()
        let languageCode = LanguageCode(rawValue: currentLanguage) ?? .english

        return languageCode.jsonFileName
    }
    
    static func changeLanguage(to language: LanguageCode) {
        Bundle.setLanguage(language.rawValue)
    }
}



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
    }
    
  // Return the current language
    static  var currentLanguage: String {
    return UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? Locale.preferredLanguages.first ?? "en"
  }
    
  // Change the language
    static func changeLanguage(to language: LanguageCode) {
        Bundle.setLanguage(language.rawValue)
    }
}


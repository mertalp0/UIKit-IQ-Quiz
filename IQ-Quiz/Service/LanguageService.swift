//
//  LanguageService.swift
//  IQ-Quiz
//
//  Created by mert alp on 7.10.2024.
//


import Foundation
final class LanguageService {
  // Return the current language
  static var currentLanguage: String {
    return UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? Locale.preferredLanguages.first ?? "en"
  }
    
  // Change the language
    static func changeLanguage(to languageCode: String) {
          UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
          UserDefaults.standard.synchronize()
          Bundle.setLanguage(languageCode)
    }
}


//
//  LanguageService.swift
//  IQ-Quiz
//
//  Created by mert alp on 7.10.2024.
//


import Foundation
final class LanguageService {
    
    static  let shared = LanguageService()
    
  // Return the current language
   var currentLanguage: String {
    return UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? Locale.preferredLanguages.first ?? "en"
  }
    
  // Change the language
     func changeLanguage(to languageCode: String) {
          UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
          UserDefaults.standard.synchronize()
          Bundle.setLanguage(languageCode)
          print(currentLanguage)
    }
}


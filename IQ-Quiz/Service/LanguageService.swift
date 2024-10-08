////
////  LanguageService.swift
////  IQ-Quiz
////
////  Created by mert alp on 7.10.2024.
////
//
//
//import Foundation
//
//final class LanguageService {
//
//    // Mevcut dili döndür
//    static var currentLanguage: String {
//        return UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? Locale.preferredLanguages.first ?? "en"
//    }
//
//    // Dili değiştir
//    static func changeLanguage(to languageCode: String) {
//        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        NotificationCenter.default.post(name: .languageDidChange, object: nil)
//    }
//}
//
//extension Notification.Name {
//    static let languageDidChange = Notification.Name("languageDidChange")
//    
//}

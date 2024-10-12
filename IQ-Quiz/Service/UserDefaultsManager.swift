//
//  UserDefaultsManager.swift
//  IQ-Quiz
//
//  Created by mert alp on 12.10.2024.
//

import Foundation

class UserDefaultsManager {
    
    enum UserDefaultsKeys: String {
        case hasSeenOnboarding
        case hasLaunchedBefore
        case appleLanguages
    }

    static let shared = UserDefaultsManager()
    private init() {}
    
    func hasSeenOnboarding() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.hasSeenOnboarding.rawValue)
    }
    
    func setOnboardingComplete() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.hasSeenOnboarding.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    
    func hasLaunchedBefore() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.hasLaunchedBefore.rawValue)
    }
    
    func setHasLaunchedBefore() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.hasLaunchedBefore.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getCurrentLanguage() -> String {
        return UserDefaults.standard.stringArray(forKey: UserDefaultsKeys.appleLanguages.rawValue)?.first ?? Locale.preferredLanguages.first ?? "en"
    }
    
    func setLanguage(_ languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: UserDefaultsKeys.appleLanguages.rawValue)
        UserDefaults.standard.synchronize()
    }
}


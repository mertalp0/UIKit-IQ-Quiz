//  LocalizationManager.swift
//  IQ-Quiz
//
//  Created by mert alp on 8.10.2024.
//

import Foundation

final class LocalizationManager {
    
    // Singleton instance
    static let shared = LocalizationManager()
    
    // App Strings
    enum LocalizationKeys {
        static let welcomeMessage = "welcome_message"
        static let settingsTitle = "settings_title"
        static let changeLanguageMessage = "change_language_message"
        static let turkish = "turkish"
        static let english = "english"
        static let cancel = "cancel"
        static let latestTestLabel = "latest_test_label"
        static let iqLabel = "iq_label"
        static let correctAnswersLabel = "correct_answers_label"
        static let noDateAvailable = "no_date_available"
        
        static let homeButtonTitle = "home_button_title"
        static let scoreLabel = "score_label"
        static let iqScoreLabel = "iq_score_label"
        static let nextButtonLabel = "next_button_label"
        static let alertTitle = "alert_title"
        static let alertMessage = "alert_select_option_message"
        static let finishButtonLabel = "finish_button_label"
        static let iqTestCommunication = "iq_tesd_communication"
        
        static let iqNotificationTitle = "iq_notification_title"
        static let iqNotificationBody = "iq_notification_body"

    }
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    // Localized string fetcher
    static func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    
    func welcomeMessage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.welcomeMessage)
    }
    
    func settingsTitle() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.settingsTitle)
    }
    
    func changeLanguageMessage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.changeLanguageMessage)
    }
    
    func turkishLanguage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.turkish)
    }
    
    func englishLanguage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.english)
    }
    
    func cancelButton() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.cancel)
    }
    
    func latestTestLabel() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.latestTestLabel)
    }
    
    func iqLabel(withScore score: Int) -> String {
        let format = LocalizationManager.localizedString(forKey: LocalizationKeys.iqLabel)
        return String(format: format, "\(score)")
    }

    
    func correctAnswersLabel(withCount count: Int) -> String {
        let format = LocalizationManager.localizedString(forKey: LocalizationKeys.correctAnswersLabel)
        return String(format: format, "\(count)")
    }
    
    func noDateAvailable() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.noDateAvailable)
    }
    
    func homeButtonTitle() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.homeButtonTitle)
    }
    func scoreLabel(withCorrectCount count: Int) -> String {
        let format = LocalizationManager.localizedString(forKey: LocalizationKeys.scoreLabel)
        return String(format: format, "\(count)")
    }
    
    func iqScoreLabel(withIQScore score: Int) -> String {
        let format = LocalizationManager.localizedString(forKey: LocalizationKeys.iqScoreLabel)
        return String(format: format, "\(score)")
    }
    
    func nextButtonLabel() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.nextButtonLabel)
        
    }
    
    func alertTitle() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.alertTitle)
        
    }
    
    func alertMessage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.alertMessage)
    }
    
    func finishButtonLabel() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.finishButtonLabel)
    }
    
    func iqTestCommunication() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.iqTestCommunication)
    }
    
    func iqNotificationTitle() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.iqNotificationTitle)
    }
    
    func iqNotificationBody() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.iqNotificationBody)
    }
    
}

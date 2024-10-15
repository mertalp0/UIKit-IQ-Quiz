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
        static let spanish = "spanish"
        static let cancel = "cancel"
        static let german = "german"
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
        
        static let onboardingTitleOne = "onboarding_title_one"
        static let onboardingBodyOne = "onboarding_body_one"
        
        static let onboardingTitleTwo = "onboarding_title_two"
        static let onboardingBodyTwo = "onboarding_body_two"
        
        static let onboardingTitleThree = "onboarding_title_three"
        static let onboardingBodyThree = "onboarding_body_three"
        
        static let onboardingButtonTitleOne = "onboarding_button_title_one"
        static let onboardingButtonTitleTwo = "onboarding_button_title_two"
        static let onboardingButtonTitleThree = "onboarding_button_title_three"
        
        static let emptyStateLabel = "empty_state_label"

    }
    
    enum OnboaringPage {
        case one
        case two
        case three
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
    
    func spanishLanguage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.spanish)
    }
    
    func germanLanguage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.german)
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
    
    func iqNotificationTitle(withPage page:OnboaringPage) -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.iqNotificationBody)
    }
    
    func onboardingTitle(withPage page:OnboaringPage) -> String {
        let title : String
        
        switch page {
            
        case .one:
            title = LocalizationKeys.onboardingTitleOne
        
        case .two:
            title = LocalizationKeys.onboardingTitleTwo
            
        case .three:
            title = LocalizationKeys.onboardingTitleThree
        }
        
        return LocalizationManager.localizedString(forKey: title)
    }
    
    func onboardingBody(withPage page:OnboaringPage) -> String {
        let body : String
        
        switch page {
            
        case .one:
            body = LocalizationKeys.onboardingBodyOne
        
        case .two:
            body = LocalizationKeys.onboardingBodyTwo
            
        case .three:
            body = LocalizationKeys.onboardingBodyThree
        }
        
        return LocalizationManager.localizedString(forKey: body)
    }
    
    func onboardingButtonTitle(withPage page:OnboaringPage) -> String {
        let buttonTitle : String
        
        switch page {
            
        case .one:
            buttonTitle = LocalizationKeys.onboardingButtonTitleOne
        
        case .two:
            buttonTitle = LocalizationKeys.onboardingButtonTitleTwo
            
        case .three:
            buttonTitle = LocalizationKeys.onboardingButtonTitleThree
        }
        
        return LocalizationManager.localizedString(forKey: buttonTitle)
    }
    
    func emptyStateLabel() -> String{
        return LocalizationManager.localizedString(forKey: LocalizationKeys.emptyStateLabel)
    }
    
}

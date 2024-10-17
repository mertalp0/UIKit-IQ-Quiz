//
//  AnalyticsManager.swift
//  IQ-Quiz
//
//  Created by mert alp on 17.10.2024.
//

import Foundation
import FirebaseAnalytics

enum AnalyticsEventName: String {
    case examStarted = "exam_started"
    case examCompleted = "exam_completed"
    case languageSelected = "language_selected"
    case appUsageTime = "app_usage_time"
    case errorOccurred = "error_occurred"
}

enum Language: String {
    case english = "English"
    case turkish = "Turkish"
    case spanish = "Spanish"
}

// Event protocol
protocol AnalyticsEvent {
    var name: String { get }
    var parameters: [String: Any]? { get }
}

struct ExamStartedEvent: AnalyticsEvent {
    let language: LanguageCode

    var name: String {
        return AnalyticsEventName.examStarted.rawValue
    }

    var parameters: [String: Any]? {
        return [
            "language_code": language.rawValue
        ]
    }
}

struct ExamCompletedEvent: AnalyticsEvent {
    let score: Int
    let duration: TimeInterval

    var name: String {
        return AnalyticsEventName.examCompleted.rawValue
    }

    var parameters: [String: Any]? {
        return [
            "score": score,
            "duration": duration
        ]
    }
}

struct LanguageSelectedEvent: AnalyticsEvent {
    let language: LanguageCode

    var name: String {
        return AnalyticsEventName.languageSelected.rawValue
    }

    var parameters: [String: Any]? {
        return [
            "language_code": language.rawValue
        ]
    }
}

struct AppUsageTimeEvent: AnalyticsEvent {
    let duration: TimeInterval

    var name: String {
        return AnalyticsEventName.appUsageTime.rawValue
    }

    var parameters: [String: Any]? {
        return [
            "duration": duration
        ]
    }
}

struct ErrorEvent: AnalyticsEvent {
    let error: Error
    let additionalInfo: [String: Any]?

    var name: String {
        return AnalyticsEventName.errorOccurred.rawValue
    }

    var parameters: [String: Any]? {
        var errorDetails: [String: Any] = [
            "error_message": error.localizedDescription
        ]
        
        if let nsError = error as NSError? {
            errorDetails["error_code"] = "\(nsError.code)"
            errorDetails["error_domain"] = nsError.domain
        }

        if let info = additionalInfo {
            errorDetails.merge(info) { current, _ in current }
        }
        return errorDetails
    }
}

struct CustomEvent: AnalyticsEvent {
    let name: String
    let eventParameters: [String: Any]?

    var parameters: [String: Any]? {
        return self.eventParameters
    }
}

class AnalyticsManager {
    static let shared = AnalyticsManager()
    private init() {}

    func logEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }

    func logLanguageSelected(languageCode: LanguageCode) {
        logEvent(LanguageSelectedEvent(language: languageCode))
    }

    func logExamStarted(languageCode: LanguageCode) {
        logEvent(ExamStartedEvent(language: languageCode))
    }

    func logExamCompleted(score: Int, duration: TimeInterval) {
        logEvent(ExamCompletedEvent(score: score, duration: duration))
    }

    func logAppUsageTime(duration: TimeInterval) {
        logEvent(AppUsageTimeEvent(duration: duration))
    }
}

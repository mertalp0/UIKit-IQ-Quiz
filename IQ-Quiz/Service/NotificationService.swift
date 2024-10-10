//
//  NotificationService.swift
//  IQ-Quiz
//
//  Created by mert alp on 9.10.2024.
//

import Foundation
import UserNotifications

class NotificationService {
    
    static let shared = NotificationService()
    
    private init() {}
    
    // MARK: - Request Notification Authorization
    func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(granted)
            }
        }
    }
    
    // MARK: - Schedule Daily Notification
    func scheduleDailyNotification() {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { requests in
            let filteredRequests = requests.filter { $0.identifier == "dailyNotification" }
            
            if filteredRequests.isEmpty {
                self.createDailyNotification()
            } else {
                print("Notification is already scheduled.")
            }
        }
    }
    
    // MARK: - Create Daily Notification
    private func createDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = LocalizationManager.shared.iqNotificationTitle()
        content.body = LocalizationManager.shared.iqNotificationBody()
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 36
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
}

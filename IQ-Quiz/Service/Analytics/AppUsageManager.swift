//
//  AppUsageManager.swift
//  IQ-Quiz
//
//  Created by mert alp on 17.10.2024.
//


//
//  AppUsageManager.swift
//  IQ-Quiz
//
//  Created by mert alp on 16.10.2024.
//


import Foundation

class AppUsageManager {
    static let shared = AppUsageManager()
    
    private var startTime: Date?
    private var totalDuration: TimeInterval = 0
    
    private init() {}

    func applicationDidBecomeActive() {
        startTime = Date()
    }

    func applicationWillResignActive() {
        guard let startTime = startTime else { return }
        let duration = Date().timeIntervalSince(startTime)
        totalDuration += duration
        
        AnalyticsManager.shared.logAppUsageTime(duration: duration)

        self.startTime = nil
    }
}

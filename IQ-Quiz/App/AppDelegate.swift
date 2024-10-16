//
//  AppDelegate.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
import Firebase
import GoogleMobileAds
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Application Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFirebaseAndAds()
        requestNotificationAuthorization()
        configureLanguage()
        
        Thread.sleep(forTimeInterval: 1)
        
        return true
    }
    
    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
     
    }
    
    // MARK: - Configure Firebase And Ads
    private func configureFirebaseAndAds() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        FirebaseApp.configure()
        configureCrashlytics()
    }
    
    // MARK: - Request Notification
    private func requestNotificationAuthorization() {
        NotificationService.shared.requestNotificationAuthorization { granted in
            if granted, !UserDefaultsManager.shared.hasLaunchedBefore() {
                NotificationService.shared.scheduleDailyNotification()
                UserDefaultsManager.shared.setHasLaunchedBefore()
            }
        }
    }
    
    private func configureCrashlytics() {
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        Crashlytics.crashlytics().log("App launched - Crashlytics initialized.")
        
//        let testError = NSError(domain: "com.example.IQ-Quiz", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error for Crashlytics"])
//        Crashlytics.crashlytics().record(error: testError)
    }
    
    // MARK: - Configure Language
    private func configureLanguage() {
        if let _ = UserDefaultsManager.shared.getAppleLanguages() {
            LanguageService.changeLanguage(to: LanguageService.currentLanguageCode())
        } else if let preferredLanguageCode = Locale.preferredLanguages.first {
            LanguageService.changeLanguage(toString: preferredLanguageCode)
        }
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataService.shared.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataService.shared.saveContext()
    }
}

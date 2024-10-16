//
//  AppDelegate.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import UIKit
import CoreData
import Firebase
import GoogleMobileAds
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "QuizResult")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Application Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFirebaseAndAds()
        requestNotificationAuthorization()
        configureLanguage()
        
        // 1 second delay for splash screen
        Thread.sleep(forTimeInterval: 1)
        
        return true
    }
    
    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // No action needed on scene discard
    }
    
    // MARK: - Private Methods
    private func configureFirebaseAndAds() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        FirebaseApp.configure()
        configureCrashlytics()
    }
    
    private func requestNotificationAuthorization() {
        NotificationService.shared.requestNotificationAuthorization { granted in
            if granted {
                let hasLaunchedBefore = UserDefaultsManager.shared.hasLaunchedBefore()
                if !hasLaunchedBefore {
                    NotificationService.shared.scheduleDailyNotification()
                    UserDefaultsManager.shared.setHasLaunchedBefore()
                }
            }
        }
    }
    
    private func configureCrashlytics() {
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        Crashlytics.crashlytics().log("App launched - Crashlytics initialized.")
        
        // Example of recording a test error (non-fatal)
//        let testError = NSError(domain: "com.example.IQ-Quiz", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error for Crashlytics"])
//        Crashlytics.crashlytics().record(error: testError)
    }
    
    private func configureLanguage() {
        
        if let _ = UserDefaultsManager.shared.getAppleLanguages() {
            LanguageService.changeLanguage(to: LanguageService.currentLanguageCode())
        } else {
            if let preferredLanguageCode = Locale.preferredLanguages.first {
                LanguageService.changeLanguage(toString: preferredLanguageCode)
            }
        }
    }
}

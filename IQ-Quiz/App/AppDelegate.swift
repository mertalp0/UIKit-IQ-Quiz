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
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
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
        // Firebase and Google Ads configuration
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        FirebaseApp.configure()
        
        // Request notification permission and schedule notification
        NotificationService.shared.requestNotificationAuthorization { granted in
            if granted {
                // Check if this is the first app launch
                let hasLaunchedBefore = UserDefaultsManager.shared.hasLaunchedBefore()
                
                if !hasLaunchedBefore {
                    // First launch, schedule notification
                    NotificationService.shared.scheduleDailyNotification()
                    
                    // Set first launch flag
                    UserDefaultsManager.shared.setHasLaunchedBefore()
                } else {
                    print("App has been launched before.")
                }
            } else {
                print("Notification permission not granted.")
            }
        }

        // 1 second delay for splash screen
        Thread.sleep(forTimeInterval: 1)

        return true
    }

    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
    }
}

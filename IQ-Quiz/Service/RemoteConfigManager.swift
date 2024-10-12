//
//  RemoteConfigManager.swift
//  IQ-Quiz
//
//  Created by mert alp on 12.10.2024.
//

import FirebaseRemoteConfig
import Foundation

class RemoteConfigManager {
    
    enum RemoteConfigKeys: String {
        case showAds = "show_ads"
    }
    
    static let shared = RemoteConfigManager()
    private var remoteConfig: RemoteConfig

    private init() {
        remoteConfig = RemoteConfig.remoteConfig()

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults([
            RemoteConfigKeys.showAds.rawValue: false as NSObject
        ])
    }
    
    func fetchRemoteConfig(completion: @escaping (Bool, Error?) -> Void) {
        remoteConfig.fetchAndActivate { (status, error) in
            if let error = error {
                completion(false, error)
            } else {
                let showAds = self.remoteConfig[RemoteConfigKeys.showAds.rawValue].boolValue
                completion(showAds, nil)
            }
        }
    }
}

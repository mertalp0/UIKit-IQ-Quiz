//
//  Bundle.swift
//  IQ-Quiz
//
//  Created by mert alp on 8.10.2024.
//

import Foundation
extension Bundle {
    private static var onLanguageDispatchOnce: () = {
        object_setClass(Bundle.main, LanguageBundle.self)
    }()
    
    static func setLanguage(_ language: String) {
        Bundle.onLanguageDispatchOnce
        UserDefaultsManager.shared.setLanguage(language)
    }
}

class LanguageBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage =  UserDefaultsManager.shared.getCurrentLanguage()
        var bundle = Bundle.main
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: path) ?? Bundle.main
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

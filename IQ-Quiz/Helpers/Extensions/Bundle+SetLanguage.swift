//
//  Bundle.swift
//  IQ-Quiz
//
//  Created by mert alp on 8.10.2024.
//
import Foundation

extension Bundle {
    private static var bundleKey: UInt8 = 0

    static func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, type(of: Bundle.main))
        }

        objc_setAssociatedObject(Bundle.main, &bundleKey, language, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        let originalMethod = class_getInstanceMethod(Bundle.self, #selector(localizedString(forKey:value:table:)))
        let swizzledMethod = class_getInstanceMethod(Bundle.self, #selector(swizzled_localizedString(forKey:value:table:)))
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }

    @objc private func swizzled_localizedString(forKey key: String, value: String?, table: String?) -> String {
        guard let language = objc_getAssociatedObject(self, &Bundle.bundleKey) as? String,
              let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self.swizzled_localizedString(forKey: key, value: value, table: table)
        }

        return bundle.swizzled_localizedString(forKey: key, value: value, table: table)
    }
}

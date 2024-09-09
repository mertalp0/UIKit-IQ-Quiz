//
//  AppBar.swift
//  IQ-Quiz
//
//  Created by mert alp on 27.08.2024.
//

import UIKit

extension UILabel {
    static func makeAppBarLabel() -> UILabel {
        let label = UILabel()
        label.text = "IQTest"
        label.textColor = UIColor(hex: "#48BFE3")
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }
}

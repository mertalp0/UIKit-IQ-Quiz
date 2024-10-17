//
//  IQCalculator.swift
//  IQ-Quiz
//
//  Created by mert alp on 25.08.2024.
//

import Foundation

class IQCalculator {
    static func calculateIQ(fromCorrectAnswers correctAnswers: Int, totalQuestions: Int = 15) -> Int {
        guard totalQuestions > 0 else { return 90 }

        let scorePercentage = (Double(correctAnswers) / Double(totalQuestions)) * 100
        let iqScore = 90 + Int((scorePercentage / 100) * 40)

        return min(max(iqScore, 90), 130)
    }
}

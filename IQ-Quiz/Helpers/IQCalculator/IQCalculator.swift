//
//  IQCalculator.swift
//  IQ-Quiz
//
//  Created by mert alp on 25.08.2024.
//

import Foundation

class IQCalculator {
    static func calculateIQ(fromCorrectAnswers correctAnswers: Int, totalQuestions: Int = 15) -> Int {
        guard totalQuestions > 0 else { return 70 }
        
        let scorePercentage = (Double(correctAnswers) / Double(totalQuestions)) * 100
        
        let iqScore: Int
        if scorePercentage >= 90 {
            iqScore = 130 + Int((scorePercentage - 90) * 0.5)
        } else if scorePercentage >= 70 {
            iqScore = 100 + Int((scorePercentage - 70) * 0.75)
        } else if scorePercentage >= 50 {
            iqScore = 85 + Int((scorePercentage - 50) * 0.6)
        } else {
            iqScore = 70 + Int(scorePercentage * 0.4)
        }
        
        return min(max(iqScore, 70), 130)
    }
}

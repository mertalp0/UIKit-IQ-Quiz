//
//  IQCalculator.swift
//  IQ-Quiz
//
//  Created by mert alp on 25.08.2024.
//

import Foundation

class IQCalculator {
    static func calculateIQ(fromCorrectAnswers correctAnswers: Int, totalQuestions: Int = 15) -> Int {
        guard totalQuestions > 0 else { return 70 } // Minimum IQ 70
        
        let scorePercentage = (Double(correctAnswers) / Double(totalQuestions)) * 100
        
        // IQ puanı aralıklarına göre hesapla
        let iqScore: Int
        if scorePercentage >= 90 {
            iqScore = 130 + Int((scorePercentage - 90) * 0.5) // 130-145 arası
        } else if scorePercentage >= 70 {
            iqScore = 100 + Int((scorePercentage - 70) * 0.75) // 100-130 arası
        } else if scorePercentage >= 50 {
            iqScore = 85 + Int((scorePercentage - 50) * 0.6) // 85-100 arası
        } else {
            iqScore = 70 + Int(scorePercentage * 0.4) // 70-85 arası
        }
        
        // IQ puanını 70 ile 130 arasında sınırla
        return min(max(iqScore, 70), 130)
    }
}

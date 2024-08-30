//
//  ResultViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 23.08.2024.
//

import Foundation

class ResultViewModel: BaseViewModel , ResultViewModelProtocol {
    
    func saveResult(correctAnswers: Int, iqScore: Int) {
        CoreDataService.shared.saveQuizResult(correctAnswers: correctAnswers, iqScore: iqScore) { result in
            switch result {
            case .success:
                print("Result saved successfully!")
            case .failure(let error):
                print("Failed to save result: \(error)")
            }
        }
    }
}

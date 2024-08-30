//
//  LatestTestsViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation

class LatestTestsViewModel: BaseViewModel, LatestTestsViewModelProtocol {
    
    @Published var latestTests: [QuizResult] = []

    override init() {
        super.init()
        fetchLatestTests()
    }
    
    func fetchLatestTests() {
        CoreDataService.shared.fetchQuizResults { result in
            switch result {
            case .success(let results):
                self.latestTests = results
            case .failure:
                self.handleError(message: "Bir hata oluştu.")
            }
        }
    }
}

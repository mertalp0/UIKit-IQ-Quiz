//
//  QuizViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation
class QuizViewModel : BaseViewModel, QuizViewModelProtocol   {
    @Published var questions : [Question] = []
    
    override init() {
        super.init()
        fetchQuestions()
    }
    private func fetchQuestions(){
        startLoading()
        if let url = Bundle.main.url(forResource: "questions", withExtension: "json")  {
              do {
                  let data = try Data(contentsOf: url)
                  let decoder = JSONDecoder()
                  questions = try decoder.decode([Question].self, from: data)
              } catch {
                  print("Error decoding JSON: \(error)")
              }
          } else {
              print("JSON file not found")
          }
          
          print(questions)
        stopLoading()
    }
    
}

//
//  QuizViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation

class QuizViewModel: BaseViewModel, QuizViewModelProtocol {
    @Published var questions: [Question] = []
    var currentJsonFile : String = "questions_tr"
    override init() {
        super.init()
        fetchLanguages()
        fetchQuestions()
        
    }
    private func fetchLanguages(){
        let currentLanguage = LanguageService.currentLanguage()
        
        if currentLanguage == "en"{
            currentJsonFile = "questions_en"
        }else if currentLanguage == "tr-TR"{
            currentJsonFile = "questions_tr"
        }else if currentLanguage == "es" {
            currentJsonFile = "questions_es"
        }
    }
    
    func fetchQuestions() {
        startLoading()
        if let url = Bundle.main.url(forResource: currentJsonFile, withExtension: "json") {
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
        stopLoading()
    }
}

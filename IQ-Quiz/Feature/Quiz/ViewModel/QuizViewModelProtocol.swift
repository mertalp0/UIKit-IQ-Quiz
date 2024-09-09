//
//  QuizViewModelProtocol.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation

protocol QuizViewModelProtocol: AnyObject {
    var questions: [Question] { get }
    func fetchQuestions()
}

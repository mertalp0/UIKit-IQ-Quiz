//
//  Quesiton.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation


struct Question: Codable, Identifiable {
    let id: String
    let type: QuestionType
    let questionText: String?
    let questionImage: String?
    let options: [String]
    let correctAnswer: String
}

enum QuestionType: String, Codable {
    case textAnswer
    case imageAnswer
}

//
//  Quesiton.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation


enum QuestionType {
    case textWithOptions
    case imageWithOptions
    case textWithImages
    case imageWithImages
}

struct Question {
    let id: String
    var type: QuestionType
    var questionText: String?
    var questionImage: String?
    var options: [String]
    var correctAnswer: String?
    
}

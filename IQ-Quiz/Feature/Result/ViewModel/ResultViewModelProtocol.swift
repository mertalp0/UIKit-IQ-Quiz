//
//  ResultViewModelProtocol.swift
//  IQ-Quiz
//
//  Created by mert alp on 30.08.2024.
//

import Foundation

protocol ResultViewModelProtocol {
    func saveResult(correctAnswers: Int, iqScore: Int) -> Void
}

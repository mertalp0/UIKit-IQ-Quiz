//
//  LatestTestsViewModelProtocol.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation

protocol LatestTestsViewModelProtocol: AnyObject {
    var latestTests: [QuizResult] { get }
    func fetchLatestTests()
}

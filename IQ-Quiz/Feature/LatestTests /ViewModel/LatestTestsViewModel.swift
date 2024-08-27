//
//  LatestTestsViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import Foundation
import CoreData
import UIKit

class LatestTestsViewModel: BaseViewModel, LatestTestsViewModelProtocol {
    
    @Published var latestTests: [QuizResult] = []
    
    // Reference to Core Data context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Initializer
    override init() {
        super.init()
        fetchLatestTests()
    }
    
    func fetchLatestTests() {
        let fetchRequest: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        
        do {
            // Execute the fetch request
            let results = try context.fetch(fetchRequest)
            
            // Update the latestTests property
            latestTests = results
        } catch {
            print("Failed to fetch quiz results: \(error.localizedDescription)")
        }
    }
}

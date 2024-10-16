//
//  CoreDataService.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import CoreData
import UIKit

protocol CoreDataServiceProtocol {
    func saveContext()
    func saveQuizResult(correctAnswers: Int, iqScore: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchQuizResults(completion: @escaping (Result<[QuizResult], Error>) -> Void)
}

class CoreDataService: CoreDataServiceProtocol {
    
    static let shared = CoreDataService()
    
    private let persistentContainer: NSPersistentContainer

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "QuizResult")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Save Quiz Result
    func saveQuizResult(correctAnswers: Int, iqScore: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        context.perform {
            let newResult = QuizResult(context: self.context)
            newResult.correctAnswers = Int64(correctAnswers)
            newResult.iqScore = Int64(iqScore)
            newResult.date = Date()
            
            do {
                try self.context.save()
                completion(.success(()))
            } catch {
                print("Failed to save quiz result: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Fetch Quiz Results
    func fetchQuizResults(completion: @escaping (Result<[QuizResult], Error>) -> Void) {
        context.perform {
            let fetchRequest: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
            
            do {
                let results = try self.context.fetch(fetchRequest)
                completion(.success(results))
            } catch {
                print("Failed to fetch quiz results: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}

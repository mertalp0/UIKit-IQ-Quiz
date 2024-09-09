import Foundation
import CoreData
import UIKit

protocol CoreDataServiceProtocol {
    func saveQuizResult(correctAnswers: Int, iqScore: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchQuizResults(completion: @escaping (Result<[QuizResult], Error>) -> Void)
}

class CoreDataService: CoreDataServiceProtocol {
    
    static let shared = CoreDataService()
    
    private let context: NSManagedObjectContext
    
    private init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
  
    func saveQuizResult(correctAnswers: Int, iqScore: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let newResult = QuizResult(context: context)
        newResult.correctAnswers = Int64(correctAnswers)
        newResult.iqScore = Int64(iqScore)
        newResult.date = Date()
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    

    func fetchQuizResults(completion: @escaping (Result<[QuizResult], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }
}

  

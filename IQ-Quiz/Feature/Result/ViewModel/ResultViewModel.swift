//
//  ResultViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 23.08.2024.
//

import CoreData
import Foundation
import UIKit

class ResultViewModel : BaseViewModel {
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
     func saveResult(correctAnswers: Int, iqScore: Int) {
         let newResult = QuizResult(context: context)
         newResult.correctAnswers = Int64(correctAnswers)
         newResult.iqScore = Int64(iqScore)
         newResult.date = Date()
         
         do {
             try context.save()
             print("Result saved successfully!")
         } catch {
             print("Failed to save result: \(error)")
         }
     }
}

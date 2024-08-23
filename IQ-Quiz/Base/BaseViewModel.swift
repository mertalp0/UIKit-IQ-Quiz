//
//  BaseViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation

class BaseViewModel : ObservableObject {
    //MARK: - Properties
    @Published var isLoading : Bool = false
    @Published var errorMessage : String?
    //MARK: - Initializationz
    
    //MARK: - Loading Managment
    func startLoading(){
        DispatchQueue.main.async {
            self.isLoading = true
        }
    }
    func stopLoading(){
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    //MARK: - Error Handling
    func handleError(_ error: Error){
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
    func handleError(message : String){
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
    //MARK: - DataFetching
    //MARK: - Network
}

//
//  StartViewModel.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//

import Foundation
import UIKit

class StartViewModel : BaseViewModel, StartViewModelProtocol {
    
        private let mailService: MailService
        
      
        init(mailService: MailService = MailService.shared) {
            self.mailService = mailService
        }
        
       
        func sendEmail(from viewController: UIViewController) {
            mailService.sendEmail(from: viewController)
        }
}

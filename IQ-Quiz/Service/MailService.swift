//
//  MailService.swift
//  IQ-Quiz
//
//  Created by mert alp on 7.10.2024.
//
import Foundation
import MessageUI
import UIKit

final class MailService: NSObject, MFMailComposeViewControllerDelegate {

    static let shared = MailService()
    
    private let recipients = ["mertalp010@gmail.com"]
    private let subject = LocalizationManager.shared.IQTestCommunication()
    private let body = ""
    
    private override init() {
        super.init()
    }
    
    func sendEmail(from viewController: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(recipients)
            mailComposeVC.setSubject(subject)
            mailComposeVC.setMessageBody(body, isHTML: false)
            
            viewController.present(mailComposeVC, animated: true, completion: nil)
        } else {
            print("Mail gönderilemiyor. Cihazda mail servisi yok.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            print("Mail iptal edildi.")
        case .saved:
            print("Mail taslağı kaydedildi.")
        case .sent:
            print("Mail gönderildi.")
        case .failed:
            print("Mail gönderilemedi: \(error?.localizedDescription ?? "Bilinmeyen bir hata oluştu").")
        @unknown default:
            print("Bilinmeyen bir durum oluştu.")
        }
    }
}

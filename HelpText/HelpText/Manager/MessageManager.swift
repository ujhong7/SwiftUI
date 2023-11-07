//
//  MessageManager.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import Foundation
import SwiftUI
import MessageUI

class MessageManager: NSObject, MFMessageComposeViewControllerDelegate, ObservableObject {
    
    func sendSMS(names: [Contact], text: String, location: String, completionHandler: @escaping (Bool) -> Void) {
        if MFMessageComposeViewController.canSendText() {
            
            let messageVC = MFMessageComposeViewController()
            messageVC.recipients = names.compactMap { $0.phoneNumber }
            messageVC.body =  "📍\(location)" + "\n" + text
            messageVC.messageComposeDelegate = self
            
            if let topWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                let viewController = topWindow.rootViewController ?? UIViewController()
                viewController.present(messageVC, animated: true, completion: nil)
                completionHandler(true)
            }
        } else {
            // SMS 보낼수 없는 경우
            print("SMS is not available")
            completionHandler(false)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            print("Message cancelled")
        case .sent:
            print("Message sent")
        case .failed:
            print("Message sending failed")
        @unknown default:
            break
        }
        
    }
    
}

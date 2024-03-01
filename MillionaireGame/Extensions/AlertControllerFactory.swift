//
//  AlertControllerFactory.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 01.03.2024.
//

import UIKit

protocol AlertFactoryProtocol {
    func createAlert(type: AlertType, completion: @escaping (Bool) -> Void) -> UIAlertController
}

final class AlertControllerFactory: AlertFactoryProtocol {
    func createAlert(type: AlertType, completion: @escaping (Bool) -> Void) -> UIAlertController {
        let alertController = UIAlertController(
            title: type.title,
            message: type.message,
            preferredStyle: .alert
        )
        
        let titleFont = UIFont.systemFont(ofSize: 20.0)
        let titleColor: UIColor = (type == .loseInformation) ? .red : .black
        let attributedTitle = NSAttributedString(string: type.title, attributes: [
            NSAttributedString.Key.font: titleFont,
            NSAttributedString.Key.foregroundColor: titleColor
        ])
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        
        switch type {
        case .information, .loseInformation:
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completion(true)
            }
            alertController.addAction(okAction)
        case .action:
            let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                completion(true)
            }
            let noAction = UIAlertAction(title: "No", style: .default) { _ in
                completion(false)
            }
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
        }
        
        return alertController
    }
}

enum AlertType {
    case information
    case loseInformation
    case action
    
    var title: String {
        switch self {
        case .information:
            return "Incorrect Text Format 😏"
        case .loseInformation:
            return "You Lose 🫣"
        case .action:
            return "Do you want to take money 🫢?"
        }
    }
    
    var message: String {
        switch self {
        case .information:
            return "Use Latin letters"
        case .loseInformation:
            return "You lost, look at the game results"
        case .action:
            return "You can take your winnings or continue playing"
        }
    }
}

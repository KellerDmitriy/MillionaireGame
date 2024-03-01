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
            return "Incorrect Text Format"
        case .loseInformation:
            return "You Lose"
        case .action:
            return "Do you want to withdraw money?"
        }
    }
    
    var message: String {
        switch self {
        case .information:
            return "Use Latin letters"
        case .loseInformation:
            return "You lost, look at the game results"
        case .action:
            return "You can withdraw your winnings or continue playing"
        }
    }
}

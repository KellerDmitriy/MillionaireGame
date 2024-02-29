//
//  ButtonFactory.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

struct ButtonFactory {
    static func makeButton(title: String, action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .robotoExtraBold32()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .darkGray
        
        // Обводка
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        
        // Тень
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        
        let uiAction = UIAction() { _ in
            action()
        }
        button.addAction(uiAction, for: .primaryActionTriggered)
        return button
    }
}

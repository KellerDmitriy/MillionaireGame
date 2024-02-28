//
//  ButtonFactory.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

struct ButtonFactory {
    static func makeButton(title: String, color: UIColor, backgroundColor: UIColor, cornerRadius: CGFloat, action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .robotoExtraBold32()
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        
        // Градиентный слой
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor] // Пример градиентных цветов
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        button.layer.insertSublayer(gradientLayer, at: 0)
        
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

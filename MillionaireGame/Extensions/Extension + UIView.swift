//
//  Extension + UIView.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit.UIView

extension UIView {
    func addVerticalGradientLayer() {
        let bottomColor = UIColor(
            red: 30/255,
            green: 38/255,
            blue: 79/255,
            alpha: 1.0
        )
        
        let middleColor = UIColor(
            red: 59/255,
            green: 89/255,
            blue: 152/255,
            alpha: 1.0
        )
        
        let topColor = UIColor(
            red: 99/255,
            green: 138/255,
            blue: 199/255,
            alpha: 1.0
        )
        
        let grayColor = UIColor(
            red: 128/255,
            green: 128/255,
            blue: 128/255,
            alpha: 1.0
        )
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [bottomColor.cgColor, middleColor.cgColor, topColor.cgColor, grayColor.cgColor]
        gradient.locations = [0.0, 0.33, 0.66, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradient, at: 0)
        
        // Анимация изменения цвета
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [bottomColor.cgColor, middleColor.cgColor, topColor.cgColor, grayColor.cgColor]
        animation.toValue = [grayColor.cgColor, topColor.cgColor, middleColor.cgColor, bottomColor.cgColor]
        animation.duration = 4.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: nil)
    }
}

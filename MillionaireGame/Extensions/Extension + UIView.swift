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
            red: 0/255,
            green: 0/255,
            blue: 128/255,
            alpha: 1
        )
        
        let middleColor = UIColor(
            red: 128/255,
            green: 50/255,
            blue: 128/255,
            alpha: 1
        )
        
        let topColor = UIColor(
            red: 135/255,
            green: 206/255,
            blue: 250/255,
            alpha: 1
        )
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [bottomColor.cgColor, middleColor.cgColor, topColor.cgColor]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradient, at: 0)
        
        // Анимация изменения цвета
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [bottomColor.cgColor, middleColor.cgColor, topColor.cgColor]
        animation.toValue = [topColor.cgColor, middleColor.cgColor, bottomColor.cgColor]
        animation.duration = 4.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: nil)
    }
}

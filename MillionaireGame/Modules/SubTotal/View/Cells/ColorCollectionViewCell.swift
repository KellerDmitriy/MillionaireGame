//
//  ColorCollectionViewCell.swift
//  MillionaireGame
//
//  Created by Александра Савчук on 29.02.2024.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    private let colorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blueViewBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(colorImageView)
        addSubview(numberLabel)
        addSubview(sumLabel)
        
        NSLayoutConstraint.activate([
            colorImageView.topAnchor.constraint(equalTo: topAnchor),
            colorImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            sumLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sumLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    func configureCell(level: Int, amount: String, prizeLevel: Int, correct: Bool) {
        numberLabel.text = "\(level):"
        sumLabel.text = amount
        
        let nonBurnableBackground = "purpleViewBackground"
        let victoryBackground = "yellowViewBackground"
        let regularBackground = "blueViewBackground"
        let currentBackground = "greenViewBackground"
        let loseBackground = "redViewBackground"
        
        var backgroundImageName: String
        switch level {
        case 5, 10:
            backgroundImageName = nonBurnableBackground
        case 15:
            backgroundImageName = victoryBackground
        default:
            backgroundImageName = regularBackground
        }
        colorImageView.image = UIImage(named: backgroundImageName)
        if prizeLevel == level {
            colorImageView.image = UIImage(named: correct ? currentBackground : loseBackground)
        }
    }
}

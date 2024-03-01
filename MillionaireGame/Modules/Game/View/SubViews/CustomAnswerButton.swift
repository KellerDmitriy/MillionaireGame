//
//  CustomButton.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

final class CustomAnswerButton: UIButton {
    var answerText: String
    var letterAnswer: String
    private let answerLetterLabel: UILabel = {
        $0.font = .robotoMedium24()
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.adjustsFontSizeToFitWidth = true
        $0.adjustsFontForContentSizeCategory = true
        return $0
    }(UILabel())
    
    private let answerLabel: UILabel = {
        $0.font = .robotoMedium24()
        $0.textColor = .white
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    private let labelStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    init(answerText: String, letterAnswer: String) {
        self.answerText = answerText
        self.letterAnswer = letterAnswer
        super.init(frame: .zero)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUptext(text: String){
        answerLetterLabel.text = text
        answerText = text
    }
    
    private func setupUI() {
        addSubview(labelStackView)
        [
            answerLetterLabel,
            answerLabel
        ].forEach({ labelStackView.addArrangedSubview($0) })
        
        labelStackView.isUserInteractionEnabled = false
        setBackgroundImage(.blueViewBackground, for: .normal)
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.4834214449, green: 0.4834213853, blue: 0.4834214449, alpha: 1)
        
        layer.shadowOffset = CGSize(width: 9, height: 8)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.masksToBounds = false
        
        answerLabel.text = letterAnswer
    }
    
    func setValue(answer: String) {
        answerLabel.text = answer
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            heightAnchor.constraint(equalToConstant: 54),
            widthAnchor.constraint(equalToConstant: 322)
        ])
    }
}

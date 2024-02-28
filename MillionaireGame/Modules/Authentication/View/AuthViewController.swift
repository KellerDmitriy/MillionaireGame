//
//  ViewController.swift
//  MillionaireGame
//
//  Created by lukoom on 25.02.2024.
//

import UIKit

final class AuthViewController: UIViewController {

    private let button: UIButton = {
            let button = UIButton()
            button.setTitle("Регистрация", for: .normal)
            let customColor = UIColor(
                red: CGFloat(0x95) / 255.0,
                green: CGFloat(0xD5) / 255.0,
                blue: CGFloat(0xE3) / 255.0,
                alpha: 1.0)
            button.titleLabel?.font = UIFont(name: "Roboto-Black", size: 28)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 24)
            button.backgroundColor = customColor
            button.layer.cornerRadius = 6
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        
        private let textField = {
            let text = UITextField()
            text.backgroundColor = UIColor.clear
            text.layer.cornerRadius = 10
            text.layer.masksToBounds = true
            text.layer.borderWidth = 1.0
            text.layer.borderColor = UIColor.white.cgColor
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
        
        private let backgroundImage = {
            let backgroundImage = UIImageView()
            backgroundImage.image = UIImage(named: "backgroundGold")
            backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
            return backgroundImage
        }()
        
        private let logoImage = {
            let logoImage = UIImageView()
            logoImage.image = UIImage(named: "logo")
            logoImage.contentMode =  UIView.ContentMode.scaleAspectFill
            return logoImage
        }()
        
        private let nickNameLabel: UILabel = {
            let nickLabel = UILabel()
            nickLabel.textAlignment = .left
            nickLabel.text = "Введите свой никнейм"
            nickLabel.textColor = .white
            nickLabel.font = UIFont(name: "Roboto-Bold", size: 28)
            return nickLabel
        }()
        
        var presenter: HomePresenterProtocol!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            textField.delegate = self
            
            backgroundImage.translatesAutoresizingMaskIntoConstraints = false
            logoImage.translatesAutoresizingMaskIntoConstraints = false
            nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(backgroundImage)
            view.addSubview(logoImage)
            view.addSubview(nickNameLabel)
            view.addSubview(textField)
            view.addSubview(button)
            
            
            NSLayoutConstraint.activate([
                backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            NSLayoutConstraint.activate([
                logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                logoImage.widthAnchor.constraint(equalToConstant: 201),
                logoImage.heightAnchor.constraint(equalToConstant: 201)
            ])
            
            NSLayoutConstraint.activate([
                nickNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nickNameLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 10),
            ])
        
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 10),
                textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                textField.widthAnchor.constraint(equalToConstant: 260),
                textField.heightAnchor.constraint(equalToConstant: 50),
            ])
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 25),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.widthAnchor.constraint(equalToConstant: 260),
                button.heightAnchor.constraint(equalToConstant: 50),
                
            ])
        }
    }

extension AuthViewController: AuthViewProtocol {
    
}

extension AuthViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let presenter = presenter as? AuthPresenter else { return true }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        presenter.updateTextFieldText(updatedText)
        
        return true
    }
}

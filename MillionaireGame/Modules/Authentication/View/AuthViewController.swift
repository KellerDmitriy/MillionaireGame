//
//  ViewController.swift
//  MillionaireGame
//
//  Created by lukoom on 25.02.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    var presenter: AuthPresenterProtocol!
    
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
    
    private lazy var authButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "Play") { [weak self] in
                self?.authButtonTap()
            }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        setViews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Setup UI
    private func setViews() {
        view.addSubview(logoImage)
        view.addSubview(nickNameLabel)
        view.addSubview(textField)
        view.addSubview(authButton)
        view.addVerticalGradientLayer()
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        
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
            authButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 25),
            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButton.widthAnchor.constraint(equalToConstant: 260),
            authButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension AuthViewController: AuthViewProtocol {
    func authButtonTap() {
        presenter.routeToGame()
    }
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

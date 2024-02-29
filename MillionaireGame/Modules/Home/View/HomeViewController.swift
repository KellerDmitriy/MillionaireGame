//
//  ViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol!
    
    private lazy var logoImage = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "logo")
        logoImage.contentMode =  UIView.ContentMode.scaleAspectFill
        return logoImage
    }()
    
    private lazy var authButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "START GAME") { [weak self] in
                self?.startGameButtonTapped()
            }
    }()
    
    private lazy var rulesButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "RULES") { [weak self] in
                self?.rulesButtonTapped()
            }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        
    }
    
    // MARK: - Setup UI
    private func setViews() {
        view.addVerticalGradientLayer()
        view.addSubview(authButton)
        view.addSubview(rulesButton)
        view.addSubview(logoImage)
        
        rulesButton.translatesAutoresizingMaskIntoConstraints = false
        authButton.translatesAutoresizingMaskIntoConstraints = false
        logoImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            authButton.widthAnchor.constraint(equalToConstant: 300),
            authButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            rulesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesButton.topAnchor.constraint(equalTo: authButton.bottomAnchor, constant: 20),
            rulesButton.widthAnchor.constraint(equalToConstant: 300),
            rulesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func startGameButtonTapped() {
        presenter.startGame()
    }
    
    @objc func rulesButtonTapped() {
        presenter.showRules()
    }
}

extension HomeViewController: HomeViewProtocol {
    
}

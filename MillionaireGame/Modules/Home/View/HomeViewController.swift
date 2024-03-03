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
        return CustomButton.makeButton(
            title: "START GAME") { [weak self] in
                self?.startGameButtonTapped()
            }
    }()
    
    private lazy var rulesButton: UIButton = {
        return CustomButton.makeButton(
            title: "Rules") { [weak self] in
                self?.rulesButtonTapped()
            }
    }()
    
    private lazy var scoreButton: UIButton = {
        return CustomButton.makeButton(
            title: "Statistic") { [weak self] in
                self?.scoreButtonTapped()
            }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Setup UI
    private func setViews() {
        view.addVerticalGradientLayer()
        view.addSubview(authButton)
        view.addSubview(rulesButton)
        view.addSubview(scoreButton)
        view.addSubview(logoImage)
        
        scoreButton.translatesAutoresizingMaskIntoConstraints = false
        rulesButton.translatesAutoresizingMaskIntoConstraints = false
        authButton.translatesAutoresizingMaskIntoConstraints = false
        logoImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            logoImage.widthAnchor.constraint(equalToConstant: 330),
            logoImage.heightAnchor.constraint(equalToConstant: 330)
        ])
        
        NSLayoutConstraint.activate([
            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 100),
            authButton.widthAnchor.constraint(equalToConstant: 300),
            authButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            rulesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesButton.topAnchor.constraint(equalTo: authButton.bottomAnchor, constant: 20),
            rulesButton.widthAnchor.constraint(equalToConstant: 250),
            rulesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
           scoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           scoreButton.topAnchor.constraint(equalTo: rulesButton.bottomAnchor, constant: 20),
           scoreButton.widthAnchor.constraint(equalToConstant: 250),
           scoreButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func startGameButtonTapped() {
        presenter.startGame()
    }
    
    func rulesButtonTapped() {
        presenter.showRules()
    }
    
    func scoreButtonTapped() {
        presenter.showScore()
    }
}

extension HomeViewController: HomeViewProtocol {
    
}

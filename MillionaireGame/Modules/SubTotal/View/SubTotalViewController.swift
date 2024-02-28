//
//  SubTotalViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

final class SubTotalViewController: UIViewController {
    var presenter: SubTotalPresenterProtocol!
    
    private let greenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .greenViewBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var continueButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "Play") { [weak self] in
                self?.continueButtonTap()
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
        
        view.addSubview(greenImageView)
        view.addSubview(continueButton)
    }
    
    private func setConstraints() {
        greenImageView.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            greenImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: greenImageView.bottomAnchor, constant: 30),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension SubTotalViewController: SubTotalViewProtocol {
    func continueButtonTap() {
        presenter.routeToGame()
       
    }
}


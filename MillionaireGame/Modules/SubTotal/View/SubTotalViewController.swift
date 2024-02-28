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
    
    // MARK: - Setup UI
    private func setViews() {
        view.addVerticalGradientLayer()
        
        view.addSubview(greenImageView)
    }
    
    private func setConstraints() {
        greenImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            greenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            greenImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
}

extension SubTotalViewController: SubTotalViewProtocol {
    func continueButtonTap() {
        
    }
}


//
//  ViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol!
    
    override func loadView() {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        view = imageView
        imageView.image = UIImage(named: "backgroundGold")
    }

override func viewDidLoad() {
        super.viewDidLoad()
    
        
       let imageView = UIImageView(image: UIImage(named: "logo"))
       imageView.contentMode = .scaleAspectFit
       
       view.addSubview(imageView)
       
       imageView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
        imageView.widthAnchor.constraint(equalToConstant: 200),
        imageView.heightAnchor.constraint(equalToConstant: 200)
       ])
    
        let firstButton = UIButton(type: .system)
        firstButton.setTitle("START GAME", for: .normal)
        firstButton.backgroundColor = UIColor.blue
        firstButton.setTitleColor(UIColor.white, for: .normal)
        firstButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        firstButton.layer.cornerRadius = 8
        firstButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        
        view.addSubview(firstButton)
        
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            firstButton.widthAnchor.constraint(equalToConstant: 200),
            firstButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let secondButton = UIButton(type: .system)
        secondButton.setTitle("RULES", for: .normal)
        secondButton.backgroundColor = UIColor.purple
        secondButton.setTitleColor(UIColor.white, for: .normal)
        secondButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        secondButton.layer.cornerRadius = 8
        secondButton.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
        
        view.addSubview(secondButton)
        
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20),
            secondButton.widthAnchor.constraint(equalToConstant: 200),
            secondButton.heightAnchor.constraint(equalToConstant: 40)
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

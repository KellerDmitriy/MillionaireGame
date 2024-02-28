//
//  ViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

final class HomeViewController: UIViewController {

    var presenter: HomePresenterProtocol!
    
    private lazy var playButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "play",
            color: .white,
            backgroundColor: .specialGreen,
            cornerRadius: 26) { [weak self] in
                self?.playButtonTap()
            }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
    }
    
    func playButtonTap() {
        presenter.routeToGame()
    }
}

extension HomeViewController: HomeViewProtocol {
    // MARK: - Setup UI
    private func setViews() {
        view.addVerticalGradientLayer()
        view.addSubview(playButton)
    }
    
    private func setConstraints() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
}


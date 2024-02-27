//
//  ViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

final class HomeViewController: UIViewController {

    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        presenter.getQuestion(difficulty: .medium)
    }
}

extension HomeViewController: HomeViewProtocol {
    
}


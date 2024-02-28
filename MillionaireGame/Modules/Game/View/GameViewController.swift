//
//  GameViewController.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Private properties
    private let backgroundImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .backgroundCrowd
        return $0
    }(UIImageView())
    
    private let logoImageView: UIImageView = {
        $0.image = .logo
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let questionLabel: UILabel = {
        $0.font = .robotoMedium24()
        $0.numberOfLines = 0
        $0.text = "TEST TEST TEST TEST TEST"
        $0.textColor = .white
        $0.textAlignment = .left
        $0.adjustsFontSizeToFitWidth = true
        $0.adjustsFontForContentSizeCategory = true
        return $0
    }(UILabel())
    
    private let questionStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 18
        $0.distribution = .fill
        return $0
    }(UIStackView())
    
    private lazy var questionNumberLabel: UILabel = {
        $0.text = "Вопрос №\(questionNumber)"
        $0.font = .robotoMedium24()
        $0.textAlignment = .left
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var questionCostLabel: UILabel = {
        $0.text = "\(questionCost) RUB"
        $0.font = .robotoMedium24()
        $0.textAlignment = .right
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let questionNumberStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let aAnswerButton = CustomAnswerButton(letter: "A:")
    private let bAnswerButton = CustomAnswerButton(letter: "B:")
    private let cAnswerButton = CustomAnswerButton(letter: "C:")
    private let dAnswerButton = CustomAnswerButton(letter: "D:")
    
    private let answerButtonStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 30
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private let fiftyHelpButton = CustomHelpButton(type: .fiftyFifty)
    private let phoneHelpButton = CustomHelpButton(type: .phone)
    private let hostHelpButton = CustomHelpButton(type: .host)
    
    private let helpButtonStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    //MARK: - Public properties
    var questionNumber = 15
    var questionCost = 100_000_000
    var presenter: GamePresenterProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
   
    
    @objc func testTimer() {
        presenter.routeToResult()
    }
}

//MARK: - GameViewProtocol
extension GameViewController: GameViewProtocol {
    
}

//MARK: - GameViewController
private extension GameViewController {
    
    func setupUI() {
        [
            backgroundImageView,
            questionStackView,
            questionNumberStackView,
            answerButtonStackView,
            helpButtonStackView
        ].forEach(view.addSubview(_:))
        
        [logoImageView, questionLabel].forEach({ questionStackView.addArrangedSubview($0) })
        
        [questionNumberLabel, questionCostLabel].forEach({ questionNumberStackView.addArrangedSubview($0) })
        
        [aAnswerButton, bAnswerButton,
         cAnswerButton, dAnswerButton
        ].forEach({ answerButtonStackView.addArrangedSubview($0) })
        
        [fiftyHelpButton, phoneHelpButton,
         hostHelpButton].forEach({ helpButtonStackView.addArrangedSubview($0) })
        
        fiftyHelpButton.addTarget(self, action: #selector(testTimer), for: .touchUpInside)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 86),
            logoImageView.widthAnchor.constraint(equalToConstant: 86)
        ])
        
        NSLayoutConstraint.activate([
            questionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            questionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            questionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            questionNumberStackView.topAnchor.constraint(equalTo: questionStackView.bottomAnchor, constant: 12),
            questionNumberStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            questionNumberStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            answerButtonStackView.topAnchor.constraint(equalTo: questionNumberStackView.bottomAnchor, constant: 24),
            answerButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            helpButtonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            helpButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}

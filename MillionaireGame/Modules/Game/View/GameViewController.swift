//
//  GameViewController.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit
import Combine

final class GameViewController: UIViewController {
    //MARK: - Private properties
    private var cancellables = Set<AnyCancellable>()
    
    private let logoImageView: UIImageView = {
        $0.image = .logo
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let questionLabel: UILabel = {
        $0.font = .robotoMedium24()
        $0.numberOfLines = 0
        $0.text = ""
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
        $0.font = .robotoMedium24()
        $0.textAlignment = .left
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var questionCostLabel: UILabel = {
       // $0.text = "\(questionCost) RUB"
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
    
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)
    
    private let aAnswerButton = CustomAnswerButton(answerText: "", letterAnswer: "A")
    private let bAnswerButton = CustomAnswerButton(answerText: "", letterAnswer: "B")
    private let cAnswerButton = CustomAnswerButton(answerText: "", letterAnswer: "C")
    private let dAnswerButton = CustomAnswerButton(answerText: "", letterAnswer: "D")
    
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
    
    private let progressBar: UIProgressView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.progressTintColor = .orange
        return $0
    }(UIProgressView(progressViewStyle: .default))
    
    //MARK: - Public properties
    //var questionCost = 100
    var presenter: GamePresenterProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        observeProgress()
        configActivityIndecator()
        setupUI()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if !presenter.isLoaded{
            activityIndicator.startAnimating()
        }
        presenter.loadEasyMediumHardData()// проверка уровня сложности
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if presenter.isLoaded{ //когда возвращаемся с subTotal, и новые данные не подгружаем
            presenter.start30Timer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - SetUp UI Text
    func setUpUIText(){
        for (index, answer) in presenter.questData[presenter.numberQuestion].allAnswers.enumerated() { // перенести в презентер
            let answerButton = [aAnswerButton, bAnswerButton, cAnswerButton, dAnswerButton][index]
            answerButton.setUptext(text: answer.answerText)
        }
        questionLabel.text = presenter.questData[presenter.numberQuestion].question
        questionNumberLabel.text = String(presenter.totalQuestion + 1)
        questionCostLabel.text = presenter.setCost()
    }
    
    //MARK: - Buttons Action
    private func observeProgress(){
        presenter.progressToGamePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] progress in
                guard let self = self else {return}
                //print("progress from vc \(progress)")
                progressBar.progress = progress
            }
            .store(in: &cancellables)
    }
    
    private func addTargetButtons(){
        aAnswerButton.addTarget(self, action: #selector(didTapAnswerButton(_:)), for: .touchUpInside)
        bAnswerButton.addTarget(self, action: #selector(didTapAnswerButton(_:)), for: .touchUpInside)
        cAnswerButton.addTarget(self, action: #selector(didTapAnswerButton(_:)), for: .touchUpInside)
        dAnswerButton.addTarget(self, action: #selector(didTapAnswerButton(_:)), for: .touchUpInside)
        
        fiftyHelpButton.addTarget(self, action: #selector(testTimer(_:)), for: .touchUpInside)
        phoneHelpButton.addTarget(self, action: #selector(testTimer(_:)), for: .touchUpInside)
        hostHelpButton.addTarget(self, action: #selector(testTimer(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapAnswerButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected //меняем состояние у нажатой кнопки чтобы потом перекрасить
        presenter.stop30Timer()
        presenter.start5Timer(music: "otvet-prinyat", completion: { [weak self] in
            guard let self = self else { return }
            let button = sender as? CustomAnswerButton
            button.map(\.anwerText).map {
                self.presenter.checkAnswer(answer: $0)
            }
        })
    }
        
    @objc func testTimer(_ sender: UIButton) {
        presenter.stop30Timer()
        takeTip(sender)
    }
    
    private func takeTip(_ sender: UIButton){
        switch sender{
        case fiftyHelpButton: presenter.fifftyFifty() //дергаем метод презентера для подсказок
        case phoneHelpButton: print("phoneHelpButton") //дергаем метод презентера для подсказок
        case hostHelpButton: print("hostHelpButton") //дергаем метод презентера для подсказок
            default: print("Default tips")}
        presenter.start30Timer()
    }
    
    private func normalStateForHelpButton(){
        fiftyHelpButton.setBackgroundImage(.fiftyFifty, for: .normal)
        phoneHelpButton.setBackgroundImage(.phone, for: .normal)
        hostHelpButton.setBackgroundImage(.host, for: .normal)
    }
    
    private func setDefaultBackGroundForAnswerButtons(){
        let arrayButtons = [aAnswerButton, bAnswerButton, cAnswerButton, dAnswerButton]
        for button in arrayButtons {
            button.setBackgroundImage(.blueViewBackground, for: .normal)
            button.isSelected = false
        }
    }
}

//MARK: - GameViewProtocol
extension GameViewController: GameViewProtocol {
    func helpFiftyFity(result: (String?, String?)) {
        let arrayButtons = [aAnswerButton, bAnswerButton, cAnswerButton, dAnswerButton]
        for button in arrayButtons{
            if let correctAnswer = result.0, button.anwerText == correctAnswer {
                button.setBackgroundImage(.blueViewBackground, for: .normal)
            } else if let incorrectAnswer = result.1, button.anwerText == incorrectAnswer {
                button.setBackgroundImage(.blueViewBackground, for: .normal)
            } else {
                button.setBackgroundImage(.yellowViewBackground, for: .normal)
            }
        }
    }
    
    func changeColorButton(isCorrect: Bool) {
        let arrayButtons = [aAnswerButton, bAnswerButton, cAnswerButton, dAnswerButton]
        for button in arrayButtons{
            if button.isSelected{ // если кнопка была нажата красим ее
                print("\(button.anwerText) correct \(isCorrect)")
                button.setBackgroundImage(isCorrect ? .greenViewBackground : .redViewBackground, for: .normal)
            }
        }
        presenter.start2Timer {
            self.presenter.routeToSubTotalOrResult(isCorrect: isCorrect)
        }
    }
    
    func cleanUI() {
        normalStateForHelpButton()
        setDefaultBackGroundForAnswerButtons()
    }
    
    func activityIndicStop() {
        activityIndicator.stopAnimating()
    }
    
    func startTimer30Sec() {
        presenter.start30Timer()
    }
    
    func setUpUIWhenLoaded() {
        addTargetButtons()
        setUpUIText()
    }
}

//MARK: - GameViewController
private extension GameViewController {
    func configActivityIndecator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .purple
    }
    
    func setupUI() {
        view.addVerticalGradientLayer()
        [
            questionStackView,
            questionNumberStackView,
            answerButtonStackView,
            helpButtonStackView,
            progressBar
        ].forEach(view.addSubview(_:))
        
        [logoImageView, questionLabel].forEach({ questionStackView.addArrangedSubview($0) })
        
        [questionNumberLabel, questionCostLabel].forEach({ questionNumberStackView.addArrangedSubview($0) })
        
        [aAnswerButton, bAnswerButton,
         cAnswerButton, dAnswerButton
        ].forEach({ answerButtonStackView.addArrangedSubview($0) })
        
        [fiftyHelpButton, phoneHelpButton,
         hostHelpButton].forEach({ helpButtonStackView.addArrangedSubview($0) })
    }
    
    func setConstraints() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
               activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               activityIndicator.topAnchor.constraint(equalTo: answerButtonStackView.bottomAnchor, constant: 25)
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
            progressBar.topAnchor.constraint(equalTo: questionNumberStackView.bottomAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            answerButtonStackView.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 30),
            answerButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            helpButtonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            helpButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

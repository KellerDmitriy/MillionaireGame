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
    var questionNumber = 1
    var questionCost = 100
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
        if !presenter.isLoaded{
            activityIndicator.startAnimating()
        } else{
            presenter.start30Timer() //когда возвращаемся с subTotal , предварительно обнулив все его счетчики
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //cancellables = Set<AnyCancellable>() // не нужно иначе при возврате с subTotal не будет срабатывать progreeBar (не будет работать observeProgress() в setUpUIWhenLoaded())
    }
    //MARK: - SetUp UI Text
    func setUpUIText(){
        for (index, answer) in presenter.questData[presenter.numberQuestion].allAnswers.enumerated() {
            let answerButton = [aAnswerButton, bAnswerButton, cAnswerButton, dAnswerButton][index]
            answerButton.setUptext(text: answer.answerText)
        }
        questionLabel.text = presenter.questData[presenter.numberQuestion].question
    }
    
    //MARK: - Buttons Action
    private func observeProgress(){
        presenter.progressToGamePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] progress in
                guard let self = self else {return}
               // print("progress from vc \(progress)")
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
        presenter.stop30Timer()
        presenter.start5Timer(music: "otvet-prinyat", completion: { [weak self] in
            guard let self = self else { return }
            switch sender {
            case self.aAnswerButton:
                print(self.aAnswerButton.anwerText)
                self.presenter.addToNumberQuestion()
                self.presenter.routeToSubTotal() // дергаем метод презентера для сравнения
            case self.bAnswerButton:
                print(self.bAnswerButton.anwerText)
                self.presenter.addToNumberQuestion()
                self.presenter.routeToSubTotal()
            case self.cAnswerButton:
                print(self.cAnswerButton.anwerText)
                self.presenter.addToNumberQuestion()
                self.presenter.routeToSubTotal()
            case self.dAnswerButton:
                print(self.dAnswerButton.anwerText)
                self.presenter.addToNumberQuestion()
                self.presenter.routeToSubTotal()
            default:
                print("Default Answers tapped")
            }
        })
    }
        
    @objc func testTimer(_ sender: UIButton) {
        presenter.stop30Timer()
        takeTip(sender)
    }
    
    private func takeTip(_ sender: UIButton){
        switch sender{
        case fiftyHelpButton: print("fiftyHelpButton") //дергаем метод презентера для подсказок
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
}

//MARK: - GameViewProtocol
extension GameViewController: GameViewProtocol {
    func cleanUI() {
        //progressBar.progress = 0
        normalStateForHelpButton()
    }
    
    func activityIndicStop() {
        activityIndicator.stopAnimating()
    }
    
    func startTimer30Sec() {
        presenter.start30Timer()
    }
    
    func setUpUIWhenLoaded() {
        addTargetButtons()
        observeProgress()
//        print("presenter easyData \(presenter.questData)")
        setUpUIText()
    }
}

//MARK: - GameViewController
private extension GameViewController {
    
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
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .purple
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
               activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
            progressBar.topAnchor.constraint(equalTo: answerButtonStackView.bottomAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            helpButtonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            helpButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//
//  GamePresenter.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import Foundation

//ViewController
protocol GameViewProtocol: AnyObject {
    func setUpUIWhenLoaded()
    func activityIndicStop()
    func cleanUI()
    func changeColorButton(isCorrect: Bool)
    
    func helpFiftyFity(result: (String?, String?))
    func helpPeople(result: String?)
    func helpFriend(result: String?)
    func showNetworkError(error: String)
}

//Presenter
protocol ManageTimerProtocol{
    var progressToGamePublisher: Published<Float>.Publisher { get }
    func start30Timer()
    func stop30Timer()
    func start5Timer(music: String, completion: @escaping () -> Void)
    func start2Timer( completion: @escaping () -> Void)
}

protocol GamePresenterProtocol: ManageTimerProtocol {
    var numberQuestion: Int { get }
    var totalQuestion: Int { get }
    var questData: [OneQuestionModel] { get }
    var isLoaded: Bool { get }
    var userName: String { get }
    
    func setCost() -> String
    func checkAnswer(answer:String)
    func checkDifficulty()
    
    func fiftyFifty()
    func helpPeople()
    func helpFriend()
    
    func routeToSubTotalOrResult(isCorrect: Bool)
    func routeToHome()
}

final class GamePresenter: GamePresenterProtocol {

    private let gameManager: GameManagerProtocol
    private let timeManager: TimeManagerProtocol
    private let router: GameRouterProtocol
    
    @Published var progress: Float = 0.0
    var progressToGamePublisher: Published<Float>.Publisher { $progress }
    var questData: [OneQuestionModel] = .init()
    var isLoaded = false //для активити индикатора
    
    private var isTappedFiftyFifty = false
    private var fiftyFiftyArray: [String] = []
    
    var numberQuestion = 0
    var totalQuestion: Int
    var difficulty: Difficulty = .easy
    var userName: String
    
    private let easyCostArray = ["100","200","300","500","1000"]
    private let mediumCostArray = ["2000","4000","8000","16000","32000"]
    private let hardCostArray = ["640000","125000","250000","500000","1000000"]
    
    weak var view: GameViewProtocol?
    
    init(userName: String,
         router: GameRouterProtocol,
         gameManager: GameManagerProtocol,
         timeManager: TimeManagerProtocol,
         totalQuestion: Int
         
    ) {
        self.userName = userName
        self.router = router
        self.gameManager = gameManager
        self.timeManager = timeManager
        self.totalQuestion = totalQuestion
        
        observeProgressBar()
    }
    //MARK: -  Help Methods
    func fiftyFifty(){
        isTappedFiftyFifty = true
        let result = gameManager.helpFiftyFifty(data: questData[numberQuestion])
        fiftyFiftyArray = gameManager.createArrayIfFiftyFiftyTapped(answers: result)
        print("result \(result)")
        print("fiftyFiftyArray \(fiftyFiftyArray)")
        view?.helpFiftyFity(result: result)
    }
    
    func helpFriend() {
        print("fiftyFiftyArray result Friend Help \(fiftyFiftyArray)")
        let result = isTappedFiftyFifty ? gameManager.randomQuestionTappedFifty(data: fiftyFiftyArray, probability: 0.8): gameManager.randomQuestion(data: questData[numberQuestion], probability: 0.8)
        view?.helpFriend(result: result)
    }
    
    func helpPeople(){
        print("fiftyFiftyArray People help \(fiftyFiftyArray)")
        let result = isTappedFiftyFifty ? gameManager.randomQuestionTappedFifty(data: fiftyFiftyArray, probability: 0.8): gameManager.randomQuestion(data: questData[numberQuestion], probability: 0.7)
        view?.helpPeople(result: result)
    }
    //MARK: - Set Cost
    func setCost() -> String{
        switch difficulty{
        case .easy: easyCostArray[numberQuestion]
        case .medium: mediumCostArray[numberQuestion]
        case .hard: hardCostArray[numberQuestion]
        }
    }
    //MARK: - Check Correct Answer or not
    func checkAnswer(answer: String) {
        let correctAnswer = questData[numberQuestion].allAnswers.first(where: \.correct)
        let isCorrect = correctAnswer?.answerText == answer
        view?.changeColorButton(isCorrect: isCorrect)
    }
    //MARK: - Check totalQuestion
    func checkTotalQuestion() {
        totalQuestion += 1
        checkNumberQuestion(totalQuestion: totalQuestion) // если не сделать numberQuestion = 0 то при переходе на другой уровень сложности вызовется view?.setUpUIWhenLoaded() и будет index out of range
        setUPDefaultUI()
    }
    //MARK: - Download Data for difficulty level
    func checkDifficulty() {
        if totalQuestion == 0{
            difficulty = .easy
            getQuestions(difficulty: difficulty)
        }else if totalQuestion == 5 {
            getQuestions(difficulty: difficulty)
            difficulty = .medium
        } else if totalQuestion == 10 {
            getQuestions(difficulty: difficulty)
            difficulty = .hard
        } else{
            start30Timer()
            print("Правильный ответ checlDifficulty \(questData[numberQuestion].allAnswers.first(where: \.correct)!)")
        }
    }
    
    //MARK: - Timer Methods
    func start30Timer() {
        timeManager.startTimer30Seconds{
            self.routeToSubTotalOrResult(isCorrect: false)
        }
    }
    
    func stop30Timer() {
        timeManager.stopTimer30Seconds()
    }
    
    func start5Timer(music: String, completion: @escaping () -> Void) {
        timeManager.startTimer5Seconds(music: music, completion: completion)
    }
    
    func start2Timer( completion: @escaping () -> Void) {
        timeManager.startTimer2Seconds(completion: completion)
    }
    
    //MARK: -  Observe progrees and CheckTotalQuestion
    private func observeProgressBar() {
        timeManager.progresPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$progress)
    }
    
    private func checkNumberQuestion(totalQuestion: Int) {
        switch totalQuestion {
        case 5, 10, 15: numberQuestion = 0
        default: numberQuestion += 1
        }
    }
    
    //MARK: -  Update UI for New Question
    private func setUPDefaultUI(){
        isTappedFiftyFifty = false
        timeManager.set30TimerGoToSubtotal()
        view?.cleanUI()
        view?.setUpUIWhenLoaded()
    }
    
    private func getQuestions(difficulty: Difficulty) {
        isLoaded = false
        Task { @MainActor in
            do {
                questData  = [] //чистим для нового запроса
                let data = try await gameManager.fetchQuestions(difficulty: difficulty)
                questData = data
                print("difficulty \(difficulty)")
                view?.setUpUIWhenLoaded()
                view?.activityIndicStop()
                start30Timer()
                print("Правильный ответ getQuestions \(questData[numberQuestion].allAnswers.first(where: \.correct)!)")
                isLoaded = true
            } catch {
                print(error.localizedDescription)
                
                view?.showNetworkError(error: error.localizedDescription)
            }
        }
    }
    
    //MARK: - Navigation
    func routeToSubTotalOrResult(isCorrect: Bool) {
        checkTotalQuestion()
        router.routeToListQuestions(userName: userName, totalQuestion: totalQuestion, isCorrect: isCorrect, timeManager: TimeManager())
    }
    
    func routeToHome() {
        router.routeToHome()
    }
}

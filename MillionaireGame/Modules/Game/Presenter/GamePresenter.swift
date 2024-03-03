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
    func startTimer30Sec()
    func cleanUI()
    func changeColorButton(isCorrect: Bool)
    
    func helpFiftyFity(result: (String?, String?))
    func helpPeople(result: String?)
    func helpFriend(result: String?)
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
    func loadEasyMediumHardData()
    func checkAnswer(answer:String)
    func checkDifficulty()
    
    func fiftyFifty()
    func helpPeople()
    func helpFriend()
    
    func routeToSubTotalOrResult(isCorrect: Bool)
}

final class GamePresenter: GamePresenterProtocol {
    private let gameManager: GameManagerProtocol
    private let timeManager: TimeManagerProtocol
    private let router: GameRouterProtocol
    
    @Published var progress: Float = 0.0
    var progressToGamePublisher: Published<Float>.Publisher { $progress }
    var questData: [OneQuestionModel] = .init()
    var isLoaded = false //для активити индикатора
    
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
        let result = gameManager.helpFiftyFifty(data: questData[numberQuestion])
        print("result \(result)")
        view?.helpFiftyFity(result: result)
    }
    
    func helpFriend() {
        let result = gameManager.randomQuestion(data: questData[numberQuestion], probability: 0.8)
        view?.helpFriend(result: result)
    }
    
    func helpPeople(){
        let result = gameManager.randomQuestion(data: questData[numberQuestion], probability: 0.7)
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
    func loadEasyMediumHardData() {
        if totalQuestion == 0 || totalQuestion == 5 || totalQuestion == 10  {
            print("load \(difficulty)")
            getQuestions(difficulty: difficulty)
        }
    }
    
    func checkDifficulty() {
        if totalQuestion == 5 {
            difficulty = .medium
        } else if totalQuestion == 10 {
            difficulty = .hard
        } else{
            print("nothing change in check")
        }
    }
    
    //MARK: - Timer Methods
    func start30Timer() {
        timeManager.startTimer30Seconds{
            print("Done")
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
    
    private func checkNumberQuestion(totalQuestion: Int){
        switch totalQuestion{
        case 5, 10, 15: numberQuestion = 0
            default: numberQuestion += 1 }
    }
    
    //MARK: -  Update UI for New Question
    private func setUPDefaultUI(){
        timeManager.set30TimerGoToSubtotal()
        view?.cleanUI()
        view?.setUpUIWhenLoaded()
    }
    
    private func getQuestions(difficulty: Difficulty) {
        isLoaded = false
        Task { @MainActor in
            do{
                questData  = [] //чистим для нового запроса
                let data = try await gameManager.fetchQuestions(difficulty: difficulty)
                questData = data
                print("difficulty \(difficulty)")
                isLoaded = true
                view?.setUpUIWhenLoaded()
                view?.activityIndicStop()
                view?.startTimer30Sec()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Navigation
    func routeToSubTotalOrResult(isCorrect: Bool) {
        checkTotalQuestion()
        router.routeToListQuestions(userName: userName, totalQuestion: totalQuestion, isCorrect: isCorrect, timeManager: TimeManager())
    }
}

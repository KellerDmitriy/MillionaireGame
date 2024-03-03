//
//  SubTotalPresenter.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import Foundation

protocol SubTotalViewProtocol: AnyObject {
    func continueButtonTap()
    func showLoseInfo(questionIndex: Int)
    func updateUI(questionIndex: Int)
    func showCongratulations()
}

protocol SubTotalPresenterProtocol {
    var userName: String { get }
    var isCorrect: Bool { get }
    var question: [Int : String] { get set }
    
    func moveGreenView()
    func playMusicIsCorrect()
    
    func getMoney() -> String
    func getLoseMoney() -> String
    func getMillion()
    
    func routeToGame()
    func routeToResult()
    func stop5Timer()
}

final class SubTotalPresenter: SubTotalPresenterProtocol {
    
    
    weak var view: SubTotalViewProtocol?
    private let router: SubTotalRouterProtocol
    private let timeManager: TimeManagerProtocol
    
    var userName: String
    var totalQuestion: Int
    var isCorrect: Bool
    var indexLose = 0
    
    var score = ""
   
    var question: [Int: String] = [
       15 : "1 Million ₽",
       14 : "500000 ₽",
       13 : "250000 ₽",
       12 : "128000 ₽",
       11 : "64000 ₽",
       10 : "32000 ₽",
       9 : "16000 ₽",
       8 : "8000 ₽",
       7 : "4000 ₽",
       6 : "2000 ₽",
       5 : "1000 ₽",
       4 : "500 ₽",
       3 : "300 ₽",
       2 : "200 ₽",
       1 : "100 ₽"
    ]
    
    //    MARK: - Init
    init(userName: String, router: SubTotalRouterProtocol, totalQuestion: Int, isCorrect: Bool, timeManager: TimeManager) {
        self.userName = userName
        self.router = router
        self.totalQuestion = totalQuestion
        self.isCorrect = isCorrect
        self.timeManager = timeManager
        //getMillion()
    }
    
    //    MARK: - Delegate Methods
    func moveGreenView() {
        if isCorrect {
            view?.updateUI(questionIndex: totalQuestion - 1)
        } else {
            view?.showLoseInfo(questionIndex: totalQuestion - 1)
        }
    }
    
    func playMusicIsCorrect() {
        let music = isCorrect ? "otvet-vernyiy" : "zvuk-nepravilnogo-otveta"
        start5Timer(music: music)
    }
    //    MARK: - Private Methods
    private func start5Timer(music: String) {
        timeManager.startTimer5Seconds(music: music) { [weak self] in
            print("Stop1")
            //self?.stop5Timer()
        }
    }
    
    func stop5Timer() {
        print("Stop2")
        timeManager.stop5Seconds()
    }
    
    func getMoney() -> String {
        score = question[totalQuestion] ?? ""
        return score
    }
    
    func getLoseMoney() -> Int {
        if !isCorrect {
            var key = totalQuestion
            if key % 5 != 0 {
                key = ((key / 5) * 5)
            }
            indexLose = key
        }
        return indexLose
    }
    
    func getLoseMoney() -> String {
        if !isCorrect {
            var key = totalQuestion
            if key % 5 != 0 {
                key = ((key / 5) * 5)
            }
            score = question[key] ?? "0"
        }
        return score
    }
    
    func getMillion() {
        if totalQuestion == 15{
            view?.showCongratulations()
        }
    }
    
    //MARK: - Navigation
    func routeToGame() {
        router.routeToGame(userName: userName, totalQuestion: totalQuestion)
    }
    
    func routeToResult() {
        router.routeToResult(name: userName, score: score, isLose: isCorrect)
    }
}

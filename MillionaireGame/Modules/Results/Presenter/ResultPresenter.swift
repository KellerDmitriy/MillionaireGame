import Foundation

protocol ResultViewProtocol: AnyObject {
    func setResult(name: String, result: Bool, score: String)
}

protocol ResultPresenterProtocol {
    var name: String { get }
    var score: String { get }
    var isLose: Bool { get }
    func showResult()
    func showGame()
    func showHome() 
}

final class ResultPresenter: ResultPresenterProtocol {

    weak var view: ResultViewProtocol?
    
    let router: ResultRouterProtocol
    
    let storageManager: StorageManagerProtocol
    
    var name: String
    var score: String
    var isLose: Bool
    let date: Date
    
    init(router: ResultRouterProtocol, storageManager: StorageManagerProtocol, name: String, score: String, isLose: Bool ) {
        self.router = router
        self.storageManager = storageManager
        self.name = name
        self.score = score
        self.isLose = isLose
        self.date = Date()
        saveScore()
    }
    
    func showResult() {
        self.view?.setResult(name: name, result: isLose, score: score)
    }
    
    //MARK: - Navigation
    func showGame() {
        router.routeToGame(userName: name)
    }
    
    func showHome() {
        router.routeToHome()
    }
    
    func saveScore() {
        storageManager.saveScore(name: name, score: score, date: date)
    }
}

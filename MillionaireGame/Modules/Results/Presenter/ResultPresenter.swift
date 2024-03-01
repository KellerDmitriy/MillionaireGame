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
}

final class ResultPresenter: ResultPresenterProtocol {

    weak var view: ResultViewProtocol?
    
    let router: ResultRouterProtocol
    
    var name: String
    var score: String
    var isLose: Bool
    
    init(router: ResultRouterProtocol, name: String, score: String, isLose: Bool ) {
        self.router = router
        self.name = name
        self.score = score
        self.isLose = isLose
    }
    
    func showResult() {
        self.view?.setResult(name: name, result: isLose, score: score)
    }
    
    //MARK: - Navigation
    func showGame() {
        router.playAgainButtonTap()
    }
}

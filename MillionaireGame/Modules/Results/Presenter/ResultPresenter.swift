import Foundation

protocol ResultViewProtocol: AnyObject {
    func setResult(result: Bool, count: Int)
}

protocol ResultPresenterProtocol {
    func showResult()
    func showGame()
}

final class ResultPresenter: ResultPresenterProtocol {
    
    weak var view: ResultViewProtocol?
    
    let router: ResultRouterProtocol
    init(router: ResultRouterProtocol) {
        self.router = router
    }
    
    
    //result и count будет приходить из самой игры
    func showResult() {
        self.view?.setResult(result: true, count: 1)
    }
    
    //MARK: - Navigation
    func showGame() {
        router.routeToGame()
    }
}

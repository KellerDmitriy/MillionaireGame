import Foundation

protocol ResultViewProtocol: AnyObject {
    
}

protocol ResultPresenterProtocol {
    
}

final class ResultPresenter: ResultPresenterProtocol {
    weak var view: ResultViewProtocol?
    
    let router: ResultRouterProtocol
    init(router: ResultRouterProtocol) {
        self.router = router
    }
    
    
}

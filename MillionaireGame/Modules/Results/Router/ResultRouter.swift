import UIKit

protocol ResultRouterProtocol: AnyObject {
    func routeToGame()
}

final class ResultRouter: ResultRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToGame() {
        //
    }
}

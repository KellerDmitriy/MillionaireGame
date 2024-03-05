import UIKit

protocol ResultRouterProtocol: AnyObject {
    func routeToGame(userName: String) 
    func routeToHome()
}

final class ResultRouter: ResultRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func routeToGame(userName: String) {
        guard let navigationController else { return }
        let gameViewController = GameBuilder(navigationController: navigationController).build(userName: userName, totalQuestion: 0)
        navigationController.pushViewController(gameViewController, animated: true)
    }
    
    func routeToHome() {
        guard let navigationController else { return }
        let homeViewController = HomeBuilder(navigationController: navigationController).build()
        navigationController.setViewControllers([homeViewController], animated: true)
    }
    
}

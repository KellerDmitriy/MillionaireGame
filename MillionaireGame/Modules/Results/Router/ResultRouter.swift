import UIKit

protocol ResultRouterProtocol: AnyObject {
    func playAgainButtonTap()
}

final class ResultRouter: ResultRouterProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    //переход на Экран игры / Главный Экран
    func playAgainButtonTap() {
        guard let navigationController else { return }
        let homeViewController = HomeBuilder(navigationController: navigationController).build()
        navigationController.pushViewController(homeViewController, animated: true)
    }
}

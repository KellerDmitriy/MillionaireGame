import UIKit

protocol ResultBuilderProtocol: AnyObject {
    func build() -> UIViewController
    init(navigationController: UINavigationController)
}

final class ResultBuilder: ResultBuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build() -> UIViewController {
        guard let navigationController else {
            fatalError("ResultBuilder requires a valid navigationController")
        }
        
        let viewController = ResultViewController()
        let router = ResultRouter(navigationController: navigationController)
        let presenter = ResultPresenter(router: router)
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    
}

import UIKit

protocol ResultBuilderProtocol: AnyObject {
    func build(name: String, score: String, isLose: Bool) -> UIViewController
    init(navigationController: UINavigationController)
}

final class ResultBuilder: ResultBuilderProtocol {
    weak var navigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func build(name: String, score: String, isLose: Bool) -> UIViewController {
        guard let navigationController else {
            fatalError("ResultBuilder requires a valid navigationController")
        }
        
        let viewController = ResultViewController()
        let router = ResultRouter(navigationController: navigationController)
        let presenter = ResultPresenter(router: router, name: name, score: score, isLose: isLose)
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    
}

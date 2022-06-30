import UIKit

enum MainSceneAction {
    case showDetails(pokemon: Pokemon)
    case presentErrorAlert(errorDescription: String?)
}

protocol MainSceneCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: MainSceneAction)
}

final class MainSceneCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - MainSceneCoordinating
extension MainSceneCoordinator: MainSceneCoordinating {
    func perform(action: MainSceneAction) {
        switch action {
        case .showDetails(let pokemon):
            let detailsViewController = DetailsSceneFactory.make(pokemon: pokemon)
            viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
        case .presentErrorAlert(let errrorDescription):
            let alert = UIAlertController(title: "An error occurred", message: errrorDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
}

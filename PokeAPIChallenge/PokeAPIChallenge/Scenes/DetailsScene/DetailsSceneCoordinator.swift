import UIKit

enum DetailsSceneAction {
    case presentErrorAlert(localizedDescription: String)
}

protocol DetailsSceneCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: DetailsSceneAction)
}

final class DetailsSceneCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - DetailsSceneCoordinating
extension DetailsSceneCoordinator: DetailsSceneCoordinating {
    func perform(action: DetailsSceneAction) {
        switch action {
        case .presentErrorAlert(let localizedDescription):
            let alert = UIAlertController(title: "An error occurred", message: localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
}

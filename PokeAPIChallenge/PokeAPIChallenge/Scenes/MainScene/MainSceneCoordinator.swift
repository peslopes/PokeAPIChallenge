import UIKit

enum MainSceneAction {
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
    }
}

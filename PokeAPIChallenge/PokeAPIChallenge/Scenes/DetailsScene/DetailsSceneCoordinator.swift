import UIKit

enum DetailsSceneAction {
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
    }
}

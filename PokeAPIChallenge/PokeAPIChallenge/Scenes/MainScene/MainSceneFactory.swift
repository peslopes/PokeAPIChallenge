import UIKit

enum MainSceneFactory {
    static func make() -> MainSceneViewController {
        let coordinator: MainSceneCoordinating = MainSceneCoordinator()
        let viewModel = MainSceneViewModel(coordinator: coordinator)
        let viewController = MainSceneViewController()
        viewController.viewModel = viewModel

        coordinator.viewController = viewController
        viewModel.viewController = viewController

        return viewController
    }
}

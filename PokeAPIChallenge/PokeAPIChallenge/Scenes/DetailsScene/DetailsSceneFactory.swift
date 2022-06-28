import UIKit

enum DetailsSceneFactory {
    static func make() -> DetailsSceneViewController {
        let coordinator: DetailsSceneCoordinating = DetailsSceneCoordinator()
        let viewModel = DetailsSceneViewModel(coordinator: coordinator)
        let viewController = DetailsSceneViewController(viewModel: viewModel)

        coordinator.viewController = viewController
        viewModel.viewController = viewController

        return viewController
    }
}

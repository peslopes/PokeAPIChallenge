import UIKit

enum DetailsSceneFactory {
    static func make(pokemon: Pokemon) -> DetailsSceneViewController {
        let coordinator: DetailsSceneCoordinating = DetailsSceneCoordinator()
        let viewModel = DetailsSceneViewModel(coordinator: coordinator, pokemon: pokemon)
        let viewController = DetailsSceneViewController()

        coordinator.viewController = viewController
        viewModel.viewController = viewController
        viewController.viewModel = viewModel

        return viewController
    }
}

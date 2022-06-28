import Foundation

protocol DetailsSceneViewModelContract: AnyObject {
    func doSomething()
}

final class DetailsSceneViewModel {
    private let coordinator: DetailsSceneCoordinating
    
    weak var viewController: DetailsSceneViewControllerDisplay?

    init(coordinator: DetailsSceneCoordinating = DetailsSceneCoordinator()) {
        self.coordinator = coordinator
    }
}

// MARK: - DetailsSceneViewModelContract
extension DetailsSceneViewModel: DetailsSceneViewModelContract {
    func doSomething() {
        viewController?.displaySomething()
    }
}
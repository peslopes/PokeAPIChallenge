import Foundation

protocol MainSceneViewModelContract: AnyObject {
    func getPokemonList()
    func loadMorePokemonsIfPossible()
}

final class MainSceneViewModel {
    private let coordinator: MainSceneCoordinating
    private let service: ServiceContract
    private var lastPokemonResponse: PokemonResponse?
    
    
    private let limit = 50
    private var totalPokemonsDisplayed = 0
    
    private var isLoading = false
    
    weak var viewController: MainSceneViewControllerDisplay?

    init(coordinator: MainSceneCoordinating = MainSceneCoordinator(), service: ServiceContract = MainSceneService()) {
        self.service = service
        self.coordinator = coordinator
    }
    
    private func handleResult(result: (Result<PokemonResponse, Error>)) {
        isLoading = false
        switch result {

        case .success(let response):
            lastPokemonResponse = response
            viewController?.stopLoaderAnimation()
            viewController?.displayPokemons(pokemons: response.results ?? [])
            totalPokemonsDisplayed += response.results?.count ?? .zero
            viewController?.updateLabel(text: "Showing \(totalPokemonsDisplayed) of \(response.count ?? .zero)")
        case .failure(let error):
            viewController?.stopLoaderAnimation()
            viewController?.displayError(error.localizedDescription)
        }
    }
}

// MARK: - MainSceneViewModelContract
extension MainSceneViewModel: MainSceneViewModelContract {
    func getPokemonList() {
        if !isLoading {
            viewController?.startLoaderAnimation()
            isLoading = true
            service.fetch(endpoint: MainSceneEndpoint.getList(limit: limit, offset: .zero)) { [weak self] (result: (Result<PokemonResponse, Error>)) in
                DispatchQueue.main.async {
                    self?.handleResult(result: result)
                }
            }
        }
    }
    
    func loadMorePokemonsIfPossible() {
        guard let nextRequest = lastPokemonResponse?.next else { return }
        if !isLoading {
            isLoading = true
            service.fetch(url: nextRequest) { [weak self] (result: (Result<PokemonResponse, Error>)) in
                DispatchQueue.main.async {
                    self?.handleResult(result: result)
                }
            }
        }
    }
}

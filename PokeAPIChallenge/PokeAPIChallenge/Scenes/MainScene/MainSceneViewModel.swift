import Foundation

protocol MainSceneViewModelContract: AnyObject {
    func getPokemonList()
    func loadMorePokemonsIfPossible()
    func showDetails(pokemon: Pokemon)
}

final class MainSceneViewModel {
    private let coordinator: MainSceneCoordinating
    private let parser: ParserContract
    private var lastPokemonResponse: PokemonResponse?
    
    
    private let limit = 50
    private var totalPokemonsDisplayed = 0
    
    private var isLoading = false
    
    weak var viewController: MainSceneViewControllerDisplay?

    init(coordinator: MainSceneCoordinating = MainSceneCoordinator(), parser: ParserContract = Parser()) {
        self.parser = parser
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
            coordinator.perform(action: .presentErrorAlert(errorDescription: error.localizedDescription))
        }
    }
}

// MARK: - MainSceneViewModelContract
extension MainSceneViewModel: MainSceneViewModelContract {
    func showDetails(pokemon: Pokemon) {
        coordinator.perform(action: .showDetails(pokemon: pokemon))
    }
    
    func getPokemonList() {
        if !isLoading {
            viewController?.startLoaderAnimation()
            isLoading = true
            parser.parseData(from: MainSceneEndpoint.getList(limit: limit, offset: .zero)) { [weak self] (result: (Result<PokemonResponse, Error>)) in
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
            parser.parseData(from: nextRequest) { [weak self] (result: (Result<PokemonResponse, Error>)) in
                DispatchQueue.main.async {
                    self?.handleResult(result: result)
                }
            }
        }
    }
}

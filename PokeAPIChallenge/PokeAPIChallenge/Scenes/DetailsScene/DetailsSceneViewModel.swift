import Foundation

protocol DetailsSceneViewModelContract: AnyObject {
    func loadPokemonDeatails()
}

final class DetailsSceneViewModel {
    private let coordinator: DetailsSceneCoordinating
    private let parser: ParserContract
    
    weak var viewController: DetailsSceneViewControllerDisplay?
    private let pokemon: Pokemon?

    init(coordinator: DetailsSceneCoordinating = DetailsSceneCoordinator(),
         pokemon: Pokemon? = nil, parser: ParserContract = Parser()) {
        self.coordinator = coordinator
        self.pokemon = pokemon
        self.parser = parser
    }
    
    private func loadSprites(pokemonSprites: PokemonSprites?) {
        let group = DispatchGroup()
        var spritesData: [Int: Data] = [:]
        
        guard let sprites = pokemonSprites?.sprites else { return }
        
        sprites.forEach { sprite in
            group.enter()
            parser.getRawData(from: sprite) { result in
                switch result {
                case .success(let data):
                    let index = sprites.firstIndex(of: sprite) ?? .zero
                    spritesData[index] = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            let spritesDataList = spritesData.sorted {
                $0.key < $1.key
            }.map {
                $0.value
            }
            self?.viewController?.stopLoaderAnimation()
            self?.viewController?.displayPokemonAnimation(sprites: spritesDataList, duration: 3)
        }
    }
}

// MARK: - DetailsSceneViewModelContract
extension DetailsSceneViewModel: DetailsSceneViewModelContract {
    func loadPokemonDeatails() {
        guard let pokemonURL = pokemon?.url else { return }
        viewController?.startLoaderAnimation()
        parser.parseData(from: pokemonURL) { [weak self] (result: (Result<PokemonDetails, Error>)) in
            switch(result) {
            case .success(let details):
                DispatchQueue.main.async {
                    self?.viewController?.displayPokemonDetails(pokemonDetails: details.detailsDictionary)
                }
                self?.loadSprites(pokemonSprites: details.sprites)
            case .failure(let error):
                self?.coordinator.perform(action: .presentErrorAlert(localizedDescription: error.localizedDescription))
            }
        }
    }
}

import UIKit

protocol MainSceneViewControllerDisplay: AnyObject {
    func displayPokemons(pokemons: [Pokemon])
    func displayError(_ errorDescription: String)
    func updateLabel(text: String)
    func startLoaderAnimation()
    func stopLoaderAnimation()
}

final class MainSceneViewController: UIViewController {
    
    var viewModel: MainSceneViewModelContract?
    private let cellReuseIdentifier = "PokemonCell"
    
    private var pokemonList: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        viewModel?.getPokemonList()
    }
}

// MARK: - ViewControllerViewCodeContract
extension MainSceneViewController: ViewControllerViewCodeContract {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(label)
        view.addSubview(loader)
    }
    
    func setupConstraints() {
        let margins = view.layoutMarginsGuide
        loader.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }
    
    func configureViews() {
        view.backgroundColor = .white
    }
    
    func configureNavBar() {
        title = "PokeAPI Challenge"
    }
}

extension MainSceneViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let pokemon = pokemonList[indexPath.row]
        content.text = pokemon.name ?? ""
        cell.contentConfiguration = content
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height {
            viewModel?.loadMorePokemonsIfPossible()
        }
    }
}

// MARK: - MainSceneDisplaying
extension MainSceneViewController: MainSceneViewControllerDisplay {
    func updateLabel(text: String) {
        label.text = text
    }
    
    func startLoaderAnimation() {
        loader.startAnimating()
    }
    
    func stopLoaderAnimation() {
        loader.stopAnimating()
    }
    
    func displayPokemons(pokemons: [Pokemon]) {
        pokemonList.append(contentsOf: pokemons)
    }
    
    func displayError(_ errorDescription: String) {
        let alert = UIAlertController(title: "An error occurred", message: errorDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

import UIKit

protocol DetailsSceneViewControllerDisplay: AnyObject {
    func displayPokemonAnimation(sprites: [Data], duration: TimeInterval)
    func displayPokemonDetails(pokemonDetails: [PokemonDetailsKeys: Any])
    func startLoaderAnimation()
    func stopLoaderAnimation()
}

final class DetailsSceneViewController: UIViewController {
    
    var viewModel: DetailsSceneViewModelContract?
    private let cellReuseIdentifier = "DetailCell"
    private var availableDetailKeys: [PokemonDetailsKeys] = []
    private var pokemonDetails: [PokemonDetailsKeys: Any] = [:] {
        didSet {
            availableDetailKeys = pokemonDetails.map { $0.key }.sorted { $0.id < $1.id }
            tableView.reloadData()
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageLoader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .medium
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        viewModel?.loadPokemonDeatails()
    }
}

// MARK: - ViewControllerViewCodeContract
extension DetailsSceneViewController: ViewControllerViewCodeContract {
    func buildViewHierarchy() {
        view.addSubview(imageView)
        view.addSubview(imageLoader)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        let margins = view.layoutMarginsGuide
        
        imageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        imageLoader.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        imageLoader.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }
    
    func configureViews() {
        view.backgroundColor = .white
    }
    
    func configureNavBar() { }
}

// MARK: - DetailsSceneDisplaying
extension DetailsSceneViewController: DetailsSceneViewControllerDisplay {
    func displayPokemonAnimation(sprites: [Data], duration: TimeInterval) {
        let images: [UIImage] = sprites.compactMap { sprite in
            return UIImage(data: sprite)
        }
        imageView.animationImages = images
        imageView.animationDuration = duration
        imageView.startAnimating()
    }
    
    
    func displayPokemonDetails(pokemonDetails: [PokemonDetailsKeys: Any]) {
        if let pokemonName = pokemonDetails[.name] as? String {
            title = pokemonName.capitalized
        }
        self.pokemonDetails = pokemonDetails
    }
    
    func startLoaderAnimation() {
        imageLoader.startAnimating()
    }
    
    func stopLoaderAnimation() {
        imageLoader.stopAnimating()
    }
}

extension DetailsSceneViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return availableDetailKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let detailKey = availableDetailKeys[section]
        if let stringList = pokemonDetails[detailKey] as? [String] {
            return stringList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return availableDetailKeys[section].toString
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let detailKey = availableDetailKeys[indexPath.section]
        if let stringList = pokemonDetails[detailKey] as? [String] {
            content.text = stringList[indexPath.row].capitalized
        } else {
            content.text = "\((pokemonDetails[detailKey]) ?? "")".capitalized
        }
        cell.contentConfiguration = content
        return cell
    }
}

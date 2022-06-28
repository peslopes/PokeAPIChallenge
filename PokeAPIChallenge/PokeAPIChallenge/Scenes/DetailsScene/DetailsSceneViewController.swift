import UIKit

protocol DetailsSceneViewControllerDisplay: AnyObject {
    func displaySomething()
}

final class DetailsSceneViewController: UIViewController {
    
    var viewModel: DetailsSceneViewModelContract?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    private let imageLoader: UIActivityIndicatorView = {
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        viewModel?.doSomething()
    }
}

// MARK: - ViewControllerViewCodeContract
extension DetailsSceneViewController: ViewControllerViewCodeContract {
    func buildViewHierarchy() {
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        let margins = view.layoutMarginsGuide
        
        imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 25).isActive = true
        imageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
    }
    
    func configureViews() {
        
    }
    
    func configureNavBar() {
        
    }
}

// MARK: - DetailsSceneDisplaying
extension DetailsSceneViewController: DetailsSceneViewControllerDisplay {
    func displaySomething() { }
}

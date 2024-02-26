import UIKit

final class ResultViewController: UIViewController {

    //MARK: - Properties
    
    var presenter: ResultPresenterProtocol!
    
    
    //MARK: - UI
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .background
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .logo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You losed on {attempt} attempt"
        label.font = .robotoMedium24()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "LOSE"
        label.font = .syneRegular50()
        label.textColor = .specialOrange
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var playAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("PLAY AGAIN", for: .normal)
        button.titleLabel?.font = .robotoMedium36()
        button.tintColor = .white
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var stackView = UIStackView()
    
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureStackView()
        setConstraints()
        playAgainButton.addTarget(self, action: #selector(routeToGame), for: .touchUpInside)
    }
}


//MARK: - ResultRouterProtocol

extension ResultViewController: ResultRouterProtocol {
    @objc func routeToGame() {
        print("button tapped")
    }
}


//MARK: - ResultViewProtocol

extension ResultViewController: ResultViewProtocol {
    
}


//MARK: - Private Methods

private extension ResultViewController {
    
    func configure() {
        let views = [backgroundImage, logoImage, stackView, playAgainButton]
        views.forEach { view.addSubview($0) }
    }
    
    
    func configureStackView() {
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(resultLabel)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
        
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 5),
            stackView.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 135),
            stackView.widthAnchor.constraint(equalToConstant: 345),
            
            playAgainButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            playAgainButton.heightAnchor.constraint(equalToConstant: 100),
            playAgainButton.widthAnchor.constraint(equalToConstant: 300),
            playAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85)
        ])
    }
}

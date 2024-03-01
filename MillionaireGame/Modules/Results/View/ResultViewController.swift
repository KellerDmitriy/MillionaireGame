import UIKit

final class ResultViewController: UIViewController {

    //MARK: - Properties
    
    var presenter: ResultPresenterProtocol!
    
    //MARK: - UI

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .logo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMedium24()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .syneRegular50()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playAgainButton: UIButton = {
        return CustomButton.makeButton(
            title: "PLAY AGAIN") { [weak self] in
                self?.playAgainButtonTap()
            }
    }()
    
    private var stackView = UIStackView()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureStackView()
        setConstraints()
        
        presenter.showResult()
        view.addVerticalGradientLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


//MARK: - ResultRouterProtocol

extension ResultViewController: ResultRouterProtocol {

    @objc func playAgainButtonTap() {
        presenter.showGame()
    }
}


//MARK: - ResultViewProtocol

extension ResultViewController: ResultViewProtocol {
    func setResult(name: String, result: Bool, score: Int) {
        switch result {
        case true:
            descriptionLabel.text = "You win \(score) RUB"
            resultLabel.text = "\(name) you WIN"
            resultLabel.textColor = .specialGreen
        case false:
            descriptionLabel.text = "You didn't reach victory, you won  \(score) RUB"
            resultLabel.text = "\(name) you LOSE"
            resultLabel.textColor = .specialOrange
        }
    }
}


//MARK: - Private Methods

private extension ResultViewController {
    
    func configure() {
        let views = [logoImage, stackView, playAgainButton]
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
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
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

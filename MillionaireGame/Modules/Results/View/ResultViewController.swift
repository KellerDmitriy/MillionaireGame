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
    
    private lazy var exitButton: UIButton = {
        return CustomButton.makeButton(
            title: "Quit the game") { [weak self] in
                self?.exitButtonTap()
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

//    MARK: - Private Methods
    private func playAgainButtonTap() {
        presenter.showGame()
    }

    private func exitButtonTap() {
        presenter.showHome()
    }
}


//MARK: - ResultViewProtocol

extension ResultViewController: ResultViewProtocol {
    func setResult(name: String, result: Bool, score: String) {
        switch result {
        case true:
            descriptionLabel.text = "You win \(score)"
            resultLabel.text = "\(name) you WIN"
            resultLabel.textColor = .specialGreen
        case false:
            descriptionLabel.text = "You didn't reach victory, you won  \(score)"
            resultLabel.text = "\(name) you LOSE"
            resultLabel.textColor = .specialOrange
        }
    }
}


//MARK: - Private Methods

private extension ResultViewController {
    
    func configure() {
        let views = [logoImage, stackView, playAgainButton, exitButton]
        views.forEach { view.addSubview($0) }
        
    }
    
    func configureStackView() {
        stackView.addArrangedSubview(resultLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setConstraints() {
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 135),
            stackView.widthAnchor.constraint(equalToConstant: 345),
            
            playAgainButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100),
            playAgainButton.heightAnchor.constraint(equalToConstant: 50),
            playAgainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            playAgainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            exitButton.topAnchor.constraint(equalTo: playAgainButton.bottomAnchor, constant: 16),
            exitButton.heightAnchor.constraint(equalToConstant: 50),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
        ])
    }
}

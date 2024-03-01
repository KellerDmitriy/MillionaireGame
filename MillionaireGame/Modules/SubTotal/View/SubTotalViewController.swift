//
//  SubTotalViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

final class SubTotalViewController: UIViewController {
    var presenter: SubTotalPresenterProtocol!
    
    let question: [String: String] = [
        "15": "1 Million RUB",
        "14": "500000 RUB",
        "13": "250000 RUB",
        "12": "128 RUB",
        "11": "64000 RUB",
        "10": "32000 RUB",
        "9": "16000 RUB",
        "8": "8000 RUB",
        "7": "4000 RUB",
        "6": "2000 RUB",
        "5": "1000 RUB",
        "4": "500 RUB",
        "3": "300 RUB",
        "2": "200 RUB",
        "1": "100 RUB"
    ]
    
    var nextGreenCell = true
    var greenCellIndex = 0
    var indexPathFromGame: IndexPath = .init()
    
    func setGreenCells() {
        nextGreenCell = true
        greenCellIndex = 0
    }
    
    private let greenCell = GreenCollectionViewCell()
    private let blueImageView = BlueCollectionViewCell()
    private let purpleCell = PurpleCollectionViewCell()
    private let yellowImageView = YellowCollectionViewCell()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        return collectionView
    }()
    
    private let logoImage = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "logo")
        logoImage.contentMode =  UIView.ContentMode.scaleAspectFill
        return logoImage
    }()
    
    private let loseLabel: UILabel = {
        let wonLabel = UILabel()
        wonLabel.textAlignment = .left
        wonLabel.text = "You LOSE"
        wonLabel.textColor = .red
        wonLabel.font = UIFont(name: "Roboto-Bold", size: 50)
        return wonLabel
    }()
    
    private lazy var continueButton: UIButton = {
        return CustomButton.makeButton(
            title: "Continue") { [weak self] in
                self?.continueButtonTap()
            }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        showWinView()
        setupCollectionView()
        showLoseInfo()
        presenter.moveGreenView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        greenCellIndex += 1
        if greenCellIndex > 2 {
            greenCellIndex = 0
        }
        setGreenCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.playMusicIsCorrect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private Methods
    private func showWinView() {
        loseLabel.isHidden = true
    }
    
    private func showLoseView() {
        loseLabel.isHidden = false
        collectionView.isHidden = true
    }
    
    // MARK: - Setup UI
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GreenCollectionViewCell.self, forCellWithReuseIdentifier: "GreenCell")
        collectionView.register(BlueCollectionViewCell.self, forCellWithReuseIdentifier: "BlueCell")
        collectionView.register(PurpleCollectionViewCell.self, forCellWithReuseIdentifier: "PurpleCell")
        collectionView.register(YellowCollectionViewCell.self, forCellWithReuseIdentifier: "YellowCell")
    }
    
    private func setViews() {
        view.addVerticalGradientLayer()
        view.addSubview(logoImage)
        view.addSubview(loseLabel)
        view.addSubview(collectionView)
        view.addSubview(continueButton)
    }
    
    private func setConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        loseLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoImage.widthAnchor.constraint(equalToConstant: 86),
            logoImage.heightAnchor.constraint(equalToConstant: 86),
            
            loseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
}
// MARK: - SubTotalViewProtocol
extension SubTotalViewController: SubTotalViewProtocol {
    private func showAlert(alertType: AlertType, completion: @escaping (Bool) -> Void) {
        let alertController = AlertControllerFactory().createAlert(type: alertType) { isConfirmed in
            completion(isConfirmed)
        }
        present(alertController, animated: true)
    }
    
    func continueButtonTap() {
        showAlert(alertType: .action) { isConfirmed in
            if isConfirmed {
                self.presenter.stop5Timer()
                self.presenter.routeToResult()
            } else {
                self.presenter.stop5Timer()
                self.presenter.routeToGame()
            }
        }
    }
    
    func showLoseInfo() {
        if presenter.isCorrect {
            continueButton.isHidden = false
        } else {
            continueButton.isHidden = true
            showAlert(alertType: .loseInformation) {_ in
                self.presenter.stop5Timer()
                self.presenter.routeToResult() }
        }
    }
    
    func showLoseInfo(questionIndex: Int) {
        indexPathFromGame = IndexPath(item: questionIndex, section: 0) //нужно думаю глобально сохранять index path
        print("indexPathFromGame \(indexPathFromGame)")
        collectionView.reloadData()
    }
    
    func updateUI(questionIndex: Int) {
        indexPathFromGame = IndexPath(item: questionIndex, section: 0) //нужно думаю глобально сохранять index path
        print("indexPathFromGame \(indexPathFromGame)")
        collectionView.reloadData()
    }
    
}
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SubTotalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return question.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reversedIndex = 14 - indexPath.item
        if reversedIndex == indexPathFromGame.item {
            guard let greenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreenCell", for: indexPath) as? GreenCollectionViewCell else {
                return UICollectionViewCell()
            }
            greenCell.configureCell(number:"Вопрос " + String(indexPathFromGame.item + 1), sum: question[String(indexPathFromGame.item + 1)] ?? "000")
            greenCell.setCellColor(presenter.isCorrect ? .greenViewBackground : .redViewBackground)
            return greenCell
        }

        if reversedIndex == 0 {
            guard let greenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreenCell", for: indexPath) as? GreenCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let questionData = question["1"] {
                greenCell.configureCell(number: "Вопрос 1", sum: questionData)
                greenCell.setCellColor(.blueViewBackground)
            }
            return greenCell
        } else if nextGreenCell && reversedIndex <= greenCellIndex {
            guard let greenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreenCell", for: indexPath) as? GreenCollectionViewCell else {
                return UICollectionViewCell()
            }
            greenCell.setCellColor(.greenViewBackground)
            return greenCell
            
        } else if reversedIndex == 4 || reversedIndex == 9 {
            guard let blueCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlueCell", for: indexPath) as? BlueCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let questionData = question["2"] {
                blueCell.configureCell(number: "Вопрос \(reversedIndex + 1)", sum: questionData)
            }
            return blueCell
        } else if reversedIndex == 14 {
            guard let yellowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YellowCell", for: indexPath) as? YellowCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let questionData = question["15"] {
                yellowCell.configureCell(number: "Вопрос 15", sum: questionData)
            }
            return yellowCell
        } else {
            guard let purpleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PurpleCell", for: indexPath) as? PurpleCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let questionData = question[String(reversedIndex + 1)] {
                purpleCell.configureCell(number: "Вопрос \(reversedIndex + 1)", sum: questionData)
            }
            return purpleCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 30)
    }
}


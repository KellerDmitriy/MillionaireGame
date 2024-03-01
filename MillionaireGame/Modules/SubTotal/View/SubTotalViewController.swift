//
//  SubTotalViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

final class SubTotalViewController: UIViewController {
    var presenter: SubTotalPresenterProtocol!

    var nextGreenCell = true
    var greenCellIndex = 0
    var indexPathFromGame: IndexPath = .init()
    

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
    
    lazy var winImageView: UIImageView = {
        let gif = UIImageView()
        gif.translatesAutoresizingMaskIntoConstraints = false
        return gif
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
    
    private func setGreenCells() {
        nextGreenCell = true
        greenCellIndex = 0
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
        view.addSubview(collectionView)
        view.addSubview(continueButton)
    }
    
    private func setConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoImage.widthAnchor.constraint(equalToConstant: 86),
            logoImage.heightAnchor.constraint(equalToConstant: 86),
            
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
    private func setGifImageView() {
        collectionView.isHidden = true
        view.addSubview(winImageView)
        NSLayoutConstraint.activate([
            winImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            winImageView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),
            winImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 50),
            winImageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -50),
            winImageView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -30)
        ])
    }
    
    func showCongratulations() {
        setGifImageView()
        
        guard let gifUrl = URL(string: "https://usagif.com/wp-content/uploads/gify/taylor-swift-heart-hand-gest-usagif.gif") else {
            return
        }
        
        URLSession.shared.dataTask(with: gifUrl) { data, response, error in
            if let error = error {
                print("Error loading GIF image:", error)
                return
            }
            
            guard let data = data else {
                print("No data received for GIF image")
                return
            }
       
            guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
                print("Failed to create image source")
                return
            }
            
            let frameCount = CGImageSourceGetCount(source)
            
            
            var frames: [UIImage] = []
            
         
            for i in 0..<frameCount {
                guard let frame = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                    print("Failed to create image at index \(i)")
                    continue
                }
                let uiImage = UIImage(cgImage: frame)
                frames.append(uiImage)
            }
  
            DispatchQueue.main.async {
                self.animate(with: frames)
            }
        }.resume()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.presenter.routeToResult()
        }
    }

    private func animate(with frames: [UIImage]) {
        winImageView.animationImages = frames
        winImageView.animationDuration = TimeInterval(frames.count) * 0.1
        winImageView.animationRepeatCount = 1
        winImageView.startAnimating()
    }
    
    private func showAlert(alertType: AlertType, completion: @escaping (Bool) -> Void) {
        let alertController = AlertControllerFactory().createAlert(type: alertType) { isConfirmed in
            completion(isConfirmed)
        }
        present(alertController, animated: true)
    }
    
    func continueButtonTap() {
        showAlert(alertType: .action) { [weak self] isConfirmed in
            if isConfirmed {
                self?.presenter.stop5Timer()
                self?.presenter.getMoney()
                self?.presenter.routeToResult()
            } else {
                self?.presenter.stop5Timer()
                self?.presenter.routeToGame()
            }
        }
    }
    
    func showLoseInfo() {
        if presenter.isCorrect {
            continueButton.isHidden = false
        } else {
            continueButton.isHidden = true
            showAlert(alertType: .loseInformation) { [weak self] _ in
                self?.presenter.stop5Timer()
                self?.presenter.getLoseMoney()
                self?.presenter.routeToResult() }
        }
    }
    
    func showLoseInfo(questionIndex: Int) {
        indexPathFromGame = IndexPath(item: questionIndex, section: 0) //нужно думаю глобально сохранять index path
        
        collectionView.reloadData()
    }
    
    func updateUI(questionIndex: Int) {
        indexPathFromGame = IndexPath(item: questionIndex, section: 0) //нужно думаю глобально сохранять index path
     
        collectionView.reloadData()
    }
    
}
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SubTotalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.question.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reversedIndex = 14 - indexPath.item
        let question = presenter.question
        
        if reversedIndex == indexPathFromGame.item {
            guard let greenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreenCell", for: indexPath) as? GreenCollectionViewCell else {
                return UICollectionViewCell()
            }
            greenCell.configureCell(number:"Question " + String(indexPathFromGame.item + 1), sum: question[indexPathFromGame.item + 1] ?? "000")
            greenCell.setCellColor(presenter.isCorrect ? .greenViewBackground : .redViewBackground)
            return greenCell
        }

        if reversedIndex == 0 {
            guard let greenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreenCell", for: indexPath) as? GreenCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let questionData = question[1] {
                greenCell.configureCell(number: "Question 1", sum: questionData)
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
            if let questionData = question[reversedIndex + 1] {
                blueCell.configureCell(number: "Question \(reversedIndex + 1)", sum: questionData)
            }
            return blueCell
        } else if reversedIndex == 14 {
            guard let yellowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YellowCell", for: indexPath) as? YellowCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let questionData = question[15] {
                yellowCell.configureCell(number: "Question 15", sum: questionData)
            }
            return yellowCell
        } else {
            guard let purpleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PurpleCell", for: indexPath) as? PurpleCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let questionData = question[reversedIndex + 1] {
                purpleCell.configureCell(number: "Question \(reversedIndex + 1)", sum: questionData)
            }
            return purpleCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 30)
    }
}


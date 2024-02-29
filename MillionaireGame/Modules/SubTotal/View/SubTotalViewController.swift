//
//  SubTotalViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 28.02.2024.
//

import UIKit

final class SubTotalViewController: UIViewController {
  var presenter: SubTotalPresenterProtocol!

  private let greenCell = GreenCollectionViewCell()
  private let blueImageView = BlueCollectionViewCell()

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

  private let wonLabel: UILabel = {
    let wonLabel = UILabel()
    wonLabel.textAlignment = .left
    wonLabel.text = "You won:"
    wonLabel.textColor = .white
    wonLabel.font = UIFont(name: "Roboto-Bold", size: 28)
    return wonLabel
  }()

  private let loseLabel: UILabel = {
    let wonLabel = UILabel()
    wonLabel.textAlignment = .left
    wonLabel.text = "You LOSE"
    wonLabel.textColor = .red
    wonLabel.font = UIFont(name: "Roboto-Bold", size: 50)
    return wonLabel
  }()

  private let sumLabel: UILabel = {
    let sumLabel = UILabel()
    sumLabel.textAlignment = .right
    sumLabel.text = "0 USD"
    sumLabel.textColor = .white
    sumLabel.font = UIFont(name: "Roboto-Bold", size: 28)
    return sumLabel
  }()

  private lazy var continueButton: UIButton = {
    return ButtonFactory.makeButton(
      title: "Continue") { [weak self] in
        self?.continueButtonTap()
      }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    setConstraints()
    showWinView()
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(GreenCollectionViewCell.self, forCellWithReuseIdentifier: "GreenCell")
    collectionView.register(BlueCollectionViewCell.self, forCellWithReuseIdentifier: "BlueCell")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  private func showWinView() {
    loseLabel.isHidden = true
  }

  private func showLoseView() {
    loseLabel.isHidden = false
    wonLabel.isHidden = true
    sumLabel.isHidden = true
    collectionView.isHidden = true
  }
  // MARK: - Setup UI
  private func setViews() {
    view.addVerticalGradientLayer()
    view.addSubview(logoImage)
    view.addSubview(loseLabel)
    view.addSubview(wonLabel)
    view.addSubview(sumLabel)
    view.addSubview(collectionView)
    view.addSubview(continueButton)
  }

  private func setConstraints() {
    logoImage.translatesAutoresizingMaskIntoConstraints = false
    loseLabel.translatesAutoresizingMaskIntoConstraints = false
    wonLabel.translatesAutoresizingMaskIntoConstraints = false
    wonLabel.translatesAutoresizingMaskIntoConstraints = false
    sumLabel.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    continueButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      logoImage.widthAnchor.constraint(equalToConstant: 200),
      logoImage.heightAnchor.constraint(equalToConstant: 200),

      loseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      loseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      wonLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
      wonLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -30),
      wonLabel.heightAnchor.constraint(equalToConstant: 20),

      sumLabel.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
      sumLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -30),
      sumLabel.heightAnchor.constraint(equalToConstant: 20),

      collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: 50),
      collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
      collectionView.heightAnchor.constraint(equalToConstant: 400),

      continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
      continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      continueButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

extension SubTotalViewController: SubTotalViewProtocol {
  func continueButtonTap() {
    presenter.routeToGame()
  }
}

extension SubTotalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item == 0 {
      return collectionView.dequeueReusableCell(withReuseIdentifier: "GreenCell", for: indexPath) as? GreenCollectionViewCell ?? UICollectionViewCell()
    }

    return collectionView.dequeueReusableCell(withReuseIdentifier: "BlueCell", for: indexPath) as? BlueCollectionViewCell ?? UICollectionViewCell()
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 50)
  }
}

//
//  StatisticViewController.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 03.03.2024.
//

import UIKit

final class StatisticViewController: UIViewController {
    
    private var score: [Score]?
    
    let backgroundImage = UIImageView(image: UIImage(named: "background"))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ScoreCell.self, forCellReuseIdentifier: ScoreCell.cellID)
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 15
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var  cleanButton: UIButton = {
        return CustomButton.makeButton(
            title: "Clean Statistic") { [weak self] in
                self?.cleanButtonTapped()
            }
    }()
    
    init(score: [Score]?) {
        self.score = score
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setViews()
        setupConstraints()
        setDelegate()
    }
    
    private func setViews() {
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
        view.addSubview(cleanButton)
        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: cleanButton.topAnchor, constant: -20),
            
        ])
        
        NSLayoutConstraint.activate([
            cleanButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            cleanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cleanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            cleanButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    private func cleanButtonTapped() {
        StorageManager.shared.fullScore.removeAll()
        score = []
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        
        
        let backButtonImage = UIImage(systemName: "arrow.left")
        let alignInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        navigationController?.navigationBar.backIndicatorImage = backButtonImage?.withAlignmentRectInsets(alignInsets)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
}

extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        score?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCell.cellID, for: indexPath) as? ScoreCell else { return UITableViewCell() }
        
        let score = score?[indexPath.row]
        cell.backgroundColor = .clear
        cell.configureCell(name: score?.name ?? "guest", score: score?.score ?? "")
        return cell
    }
}

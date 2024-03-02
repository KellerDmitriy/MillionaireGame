//
//  RulesViewController.swift
//  MillionaireGame
//
//  Created by Aidana Assanova on 28.02.2024.
//
import UIKit

final class RulesViewController: UIViewController {
    private let rulesText: String
    
    init(rulesText: String) {
        self.rulesText = rulesText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationController()
    }
    
    private func setupNavigationController() {
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
    
    private func setupUI() {
         let scrollView = UIScrollView()
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         
         let backgroundImage = UIImageView(image: UIImage(named: "background"))
         backgroundImage.isUserInteractionEnabled = false
         backgroundImage.contentMode = .scaleAspectFill
         scrollView.addSubview(backgroundImage)
         scrollView.sendSubviewToBack(backgroundImage)
         backgroundImage.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(scrollView)
     
         NSLayoutConstraint.activate([
             backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
             backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])

         NSLayoutConstraint.activate([
             scrollView.topAnchor.constraint(equalTo: view.topAnchor),
             scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])

         let contentView = UIView()
         contentView.translatesAutoresizingMaskIntoConstraints = false
         scrollView.addSubview(contentView)

         NSLayoutConstraint.activate([
             contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
             contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
             contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
             contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
             contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
         ])
         let titleLabel = UILabel()
         titleLabel.text = "Game Rules for \"Who Wants to Be a Millionaire?\""
         titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
         titleLabel.textColor = .white
         titleLabel.textAlignment = .center
         titleLabel.numberOfLines = 0
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         contentView.addSubview(titleLabel)

         NSLayoutConstraint.activate([
             titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15),
             titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
             titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
         ])

         let rulesLabel = UILabel()
         rulesLabel.numberOfLines = 0
         rulesLabel.textColor = .white
         rulesLabel.text = rulesText
         rulesLabel.translatesAutoresizingMaskIntoConstraints = false
         contentView.addSubview(rulesLabel)

         NSLayoutConstraint.activate([
             rulesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
             rulesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
             rulesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
             rulesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
         ])
         
         let maxHeightConstraint = contentView.heightAnchor.constraint(lessThanOrEqualTo: scrollView.heightAnchor)
         maxHeightConstraint.priority = .defaultHigh
         maxHeightConstraint.isActive = true
     }
 }

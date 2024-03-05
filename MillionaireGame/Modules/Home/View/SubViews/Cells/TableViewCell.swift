//
//  ScoreCell.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 03.03.2024.
//

import UIKit

final class ScoreCell: UITableViewCell {
    static let cellID = String(describing: ScoreCell.self)
    
    private let blueView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blueViewBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(blueView)
        addSubview(numberLabel)
        addSubview(sumLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            blueView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blueView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            sumLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sumLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: numberLabel.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: sumLabel.leadingAnchor, constant: -10)
        ])
    }
    
    func configureCell(name: String, score: String, date: Date?) {
        numberLabel.text = name
        sumLabel.text = score
        
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm (dd.MM.yyyy)"
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = "No date available"
        }
    }
}

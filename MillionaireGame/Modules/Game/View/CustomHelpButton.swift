//
//  CustomHelpButton.swift
//  MillionaireGame
//
//  Created by Razumov Pavel on 27.02.2024.
//

import UIKit

enum TypeButton {
    case fiftyFifty
    case phone
    case host
}

final class CustomHelpButton: UIButton {
    var type: TypeButton
    
    init(type: TypeButton) {
        self.type = type
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        switch type {
        case .fiftyFifty:
            setBackgroundImage(.fiftyFifty, for: .normal)
        case .phone:
            setBackgroundImage(.phone, for: .normal)
        case .host:
            setBackgroundImage(.host, for: .normal)
        }
        
        addTarget(self, action: #selector(didTapHelpButton), for: .touchUpInside)
    }
    
    @objc func didTapHelpButton() {
        switch type {
        case .fiftyFifty:
            currentBackgroundImage == .fiftyFifty
            ? setBackgroundImage(.fiftyFiftyDone, for: .normal)
            : setBackgroundImage(.fiftyFifty, for: .normal)
        case .phone:
            currentBackgroundImage == .phone
            ? setBackgroundImage(.phoneDone, for: .normal)
            : setBackgroundImage(.phone, for: .normal)
        case .host:
            currentBackgroundImage == .host
            ? setBackgroundImage(.hostDone, for: .normal)
            : setBackgroundImage(.host, for: .normal)
        }
    }
}

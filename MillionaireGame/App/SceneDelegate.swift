//
//  SceneDelegate.swift
//  MillionaireGame
//
//  Created by Келлер Дмитрий on 25.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        let homeViewController = HomeBuilder(navigationController: navigationController).build()
        navigationController.setViewControllers([homeViewController], animated: true)
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
    }


}


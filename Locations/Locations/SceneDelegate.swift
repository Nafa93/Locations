//
//  SceneDelegate.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import Foundation
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let navigationController = UINavigationController()
            coordinator = AppCoordinator(navigationController: navigationController)
            coordinator?.start()

            let window = UIWindow(windowScene: windowScene)
            self.window = window
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}

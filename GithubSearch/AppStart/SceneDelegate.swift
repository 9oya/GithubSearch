//
//  SceneDelegate.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow.init(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: rootViewController())
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    private func rootViewController() -> HomeViewController {
        let vc = HomeViewController()
        return vc
    }
}


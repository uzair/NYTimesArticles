//
//  SceneDelegate.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var rootCoordinator: ArticleListCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        let coordinatorResolver = CoordinatorResolver(navigationController: navigationController)
        
        let rootCoordinator = coordinatorResolver.articleListCoordinator()
        rootCoordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
}

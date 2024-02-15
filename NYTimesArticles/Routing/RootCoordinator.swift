//
//  RootCoordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation
import UIKit

internal final class DefaultRootCoordinator: RootCoordinator {
    
    var resolver: CoordinatorResolver?
    var childCoordinator: Coordinator?

    var presentingViewController: UIViewController?
    var navigationController: UINavigationController?
    
    func start() {
        let rootNavigationController = UINavigationController()
        rootNavigationController.modalPresentationStyle = .fullScreen
        childCoordinator?.navigationController = rootNavigationController
        childCoordinator?.start()
        presentingViewController?.present(rootNavigationController, animated: true)
        navigationController = rootNavigationController
    }
}

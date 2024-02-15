//
//  Coordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation
import UIKit

internal protocol Coordinator {

    var resolver: CoordinatorResolverContracor? { get set }
    var navigationController: UINavigationController? { get set }
    func start()
}

internal protocol RootCoordinator: Coordinator {
    var childCoordinator: Coordinator? { get set }
    var presentingViewController: UIViewController? { get set }
}

internal protocol ExitCoordinator: Coordinator {
    func exit()
}

extension Coordinator {

    // To be called within the coordinators as part of start method.
    func load(viewController: UIViewController) {
        if navigationController?.viewControllers.count == 0 {
            navigationController?.viewControllers = [viewController]
        } else {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

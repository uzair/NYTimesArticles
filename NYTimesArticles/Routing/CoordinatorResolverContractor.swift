//
//  CoordinatorResolver.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal protocol CoordinatorResolverContracor {

    func rootCoordinator() -> RootCoordinator?
    func articleListCoordinator() -> Coordinator?


}

internal extension CoordinatorResolverContracor {

    func rootCoordinator() -> RootCoordinator? {
        return DefaultRootCoordinator()
    }

}

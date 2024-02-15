//
//  CoordinatorResolver.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal protocol CoordinatorResolver {

    func rootCoordinator() -> RootCoordinator?
    func consentListCoordinator() -> Coordinator?


}

internal extension CoordinatorResolver {

    func rootCoordinator() -> RootCoordinator? {
        return DefaultRootCoordinator()
    }

}

//
//  CoordinatorResolver.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import Foundation
import UIKit

internal protocol CoordinatorResolverContractor {
    
    var navigationController: UINavigationController? { get set }
    func articleListCoordinator() -> Coordinator?
    func articleDetailCoordinator(urlString: String?) -> Coordinator?
}

final class CoordinatorResolver: CoordinatorResolverContractor {
    
     var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func articleListCoordinator() -> Coordinator? {
        
        let coordinator = ArticleListCoordinator()
        coordinator.resolver = self
        return coordinator
    }
    
    func articleDetailCoordinator(urlString: String?) -> Coordinator? {
        
        let coordinator = ArticleDetailCoordinator(articleDetailUrl: urlString)
        coordinator.resolver = self
        return coordinator
    }
    
    
    
}

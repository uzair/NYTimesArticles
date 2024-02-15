//
//  CoordinatorResolver.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import Foundation

internal final class CoordinatorResolver: CoordinatorResolverContracor {
    
    func articleListCoordinator() -> Coordinator? {
        
        let coordinator = ArticleListCoordinator()
        coordinator.resolver = self
        return coordinator
    }
    
}


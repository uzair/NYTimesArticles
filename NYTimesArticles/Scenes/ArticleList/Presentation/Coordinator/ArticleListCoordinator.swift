//
//  ArticleListCoordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit

protocol ArticleRouterContractor {
    func showDetail(articleDetailUrl: String?)
}

class ArticleListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let viewModel = ArticleListViewModel(getArticlesMetaDataUseCase: GetArticlesMetaDataUseCase(), mapper: ArticleListDisplayModelMapper(), router: self)
        let viewController = ArticleListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
}

extension ArticleListCoordinator: ArticleRouterContractor {
    
    func showDetail(articleDetailUrl: String?) {
        let articleDetailCoordinator = ArticleDetailCoordinator(articleDetailUrl: articleDetailUrl, navigationController: self.navigationController)
        articleDetailCoordinator.start()
        
    }
}

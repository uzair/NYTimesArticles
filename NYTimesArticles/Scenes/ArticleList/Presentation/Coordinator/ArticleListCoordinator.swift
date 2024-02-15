//
//  ArticleListCoordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit

class ArticleListCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
         self.navigationController = navigationController
     }

    func start() {
        
        let viewController = ArticleListViewController(coordinator: self)
        
        let viewModel = ArticleListViewModel(getArticlesMetaDataUseCase: GetArticlesMetaData(), mapper: ArticleListViewModelMapper())
        
        viewController.viewModel = viewModel
        
        self.navigationController.pushViewController(viewController, animated: false)
    }
}

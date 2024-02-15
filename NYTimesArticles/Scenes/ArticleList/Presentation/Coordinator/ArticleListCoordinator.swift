//
//  ArticleListCoordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit

class ArticleListCoordinator: Coordinator {

    var resolver: CoordinatorResolver?
    
    init() {
     }

    func start() {
        
        //let viewController = ArticleListViewController(coordinator: self)
        
        let viewModel = ArticleListViewModel(getArticlesMetaDataUseCase: GetArticlesMetaData(), mapper: ArticleListViewModelMapper(), coordinator: self)
        
        let viewController = ArticleListViewController(viewModel: viewModel)
        
        self.resolver?.navigationController.pushViewController(viewController, animated: true)
        

    }
}

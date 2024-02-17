//
//  ArticleListCoordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit

class ArticleListCoordinator: Coordinator {

    var resolver: CoordinatorResolverContractor?
    
    init() {
     }

    func start() {
        
        let viewModel = ArticleListViewModel(getArticlesMetaDataUseCase: GetArticlesMetaDataUseCase(), mapper: ArticleListViewModelMapper(), coordinator: self)
        
        let viewController = ArticleListViewController(viewModel: viewModel)
        
        self.resolver?.navigationController?.pushViewController(viewController, animated: true)
        

    }
}

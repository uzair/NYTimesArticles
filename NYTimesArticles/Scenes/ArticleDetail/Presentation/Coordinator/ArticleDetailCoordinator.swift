//
//  ArticleDetailCoordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 16/02/2024.
//

import Foundation

class ArticleDetailCoordinator: Coordinator {

    var resolver: CoordinatorResolver?
    var articleDetailUrl: String?
    
    init(articleDetailUrl: String?) {
        self.articleDetailUrl = articleDetailUrl
     }

    func start() {

        let viewModel = ArticleDetailViewModel(articleUrl: self.articleDetailUrl, coordinator: self)
        
        let viewController = ArticleDetailViewController(viewModel: viewModel)
        
        self.resolver?.navigationController.pushViewController(viewController, animated: true)
        

    }
}

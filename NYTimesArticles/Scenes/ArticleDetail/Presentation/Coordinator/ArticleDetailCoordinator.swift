//
//  ArticleDetailCoordinator.swift
//  NYTimesArticles
//
//  Created by Macbook on 16/02/2024.
//

import UIKit

class ArticleDetailCoordinator: Coordinator {
    
    var articleDetailUrl: String?
    var navigationController: UINavigationController
    
    init(articleDetailUrl: String?, navigationController: UINavigationController) {
        self.articleDetailUrl = articleDetailUrl
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ArticleDetailViewModel(articleUrl: self.articleDetailUrl, coordinator: self)
        let viewController = ArticleDetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

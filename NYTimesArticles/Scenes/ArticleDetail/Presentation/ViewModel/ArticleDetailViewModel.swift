//
//  ArticleDetailViewModel.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import Foundation

internal enum ArticleDetailViewState {
    case idle
    case loadingUrl(String?)
}

protocol ArticleDetailViewModelContractor {
    var viewState: Bind<ArticleDetailViewState> { get }
    func onViewLoad()
}

internal final class ArticleDetailViewModel: ArticleDetailViewModelContractor {
    var viewState: Bind<ArticleDetailViewState> = Bind(.idle)
    
    var coordinator: Coordinator?
    var articleUrl: String?
    
    init(articleUrl: String?, coordinator: Coordinator?) {
        self.coordinator = coordinator
        self.articleUrl = articleUrl
    }
    
    func onViewLoad() {
        self.viewState.value = .loadingUrl(self.articleUrl)
    }
    
}


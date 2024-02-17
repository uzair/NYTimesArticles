//
//  ArticleDetailViewModel.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import Foundation

enum ArticleDetailViewState: Equatable {
    case idle
    case loadingUrl(String?)
    
    static func == (lhs: ArticleDetailViewState, rhs: ArticleDetailViewState) -> Bool {
         switch (lhs, rhs) {
         case (.idle, .idle):
             return true
         case let (.loadingUrl(url1), .loadingUrl(url2)):
             return url1 == url2
         default:
             return false
         }
     }
}

protocol ArticleDetailViewModelContractor {
    var viewState: Bind<ArticleDetailViewState> { get }
    func onViewLoad()
}

final class ArticleDetailViewModel: ArticleDetailViewModelContractor {
    var viewState: Bind<ArticleDetailViewState> = Bind(.idle)
    private var coordinator: Coordinator?
    private var articleUrl: String?
    
    init(articleUrl: String?, coordinator: Coordinator?) {
        self.coordinator = coordinator
        self.articleUrl = articleUrl
    }
    
    func onViewLoad() {
        self.viewState.value = .loadingUrl(self.articleUrl)
    }
}


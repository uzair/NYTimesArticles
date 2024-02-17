//
//  ArticleListViewModel.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

enum ArticleListViewState: Equatable {
    case idle
    case loading
    case listingArticles
    case error(ServiceError)
    
    static func == (lhs: ArticleListViewState, rhs: ArticleListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.listingArticles, .listingArticles):
            return true
            
        case (.error(_), .error(_)):
            return true
            
        default:
            return false
        }
    }
}

protocol ArticleListViewModelContractor {
    var viewState: Bind<ArticleListViewState> { get }
    var listDisplayItem: ArticleListDisplayItem? { get set }
    func onViewLoad()
    func onClickListItemAt(index: Int)
}

protocol ArticleListDisplayModelMapperInterface {
    func listDisplayItem(articlesMetaData: ArticlesMetaData) -> ArticleListDisplayItem
}

final class ArticleListViewModel: ArticleListViewModelContractor {
    
    private let getArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor
    private let mapper: ArticleListDisplayModelMapperInterface
    private let router: ArticleRouterContractor
    private var articlesMetaData: ArticlesMetaData?
    var viewState: Bind<ArticleListViewState> = Bind(.idle)
    var listDisplayItem: ArticleListDisplayItem? = nil
    
    init(getArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor,
         mapper: ArticleListDisplayModelMapperInterface, router: ArticleRouterContractor) {
        
        self.getArticlesMetaDataUseCase  = getArticlesMetaDataUseCase
        self.mapper = mapper
        self.router = router
        
    }
    
    func onViewLoad() {
        onLoadArticlesMetaData()
    }
    
    func onClickListItemAt(index: Int) {
        let urlString = self.articlesMetaData?.results?[index].url
        router.showDetail(articleDetailUrl: urlString)
    }
}

private extension ArticleListViewModel {
    func onLoadArticlesMetaData() {
        viewState.value = .loading
        getArticlesMetaDataUseCase.getArticleList { [weak self] result in
            
            switch result {
            case .success(let articlesMetaData):
                self?.articlesMetaData = articlesMetaData
                if let mapper = self?.mapper {
                    self?.listDisplayItem = mapper.listDisplayItem(articlesMetaData: articlesMetaData)
                    self?.viewState.value = .listingArticles
                }
                return
            case .failure(let error):
                self?.viewState.value = .error(error)
                
            }
        }
    }
}

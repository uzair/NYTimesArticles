//
//  ArticleListViewModel.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal enum ArticleListViewState {
    case idle
    case loading
    case listingArticles(ArticleListDisplayItem)
    case error(ServiceError)
}

protocol ArticleListViewModelContractor {
    var viewState: Bind<ArticleListViewState> { get }
    func onViewLoad()
    func onClickListItemAt(index: Int)
}


protocol ArticleListViewModelMapperInterface {
    func listDisplayItem(articlesMetaData: ArticlesMetaData) -> ArticleListDisplayItem
}

internal final class ArticleListViewModel: ArticleListViewModelContractor {
    
    private let getArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor
    private var articlesMetaData: ArticlesMetaData?
    
    var mapper: ArticleListViewModelMapperInterface?
    
    var viewState: Bind<ArticleListViewState> = Bind(.idle)
    var coordinator: Coordinator?
    
    init(getArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor,
         mapper: ArticleListViewModelMapperInterface?, coordinator: Coordinator?) {
        
        self.getArticlesMetaDataUseCase  = getArticlesMetaDataUseCase
        self.mapper = mapper
        self.coordinator = coordinator
        
    }
    
    func onViewLoad() {
        onLoadArticlesMetaData()
    }
    
    func onClickListItemAt(index: Int) {
        
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
                    self?.viewState.value = .listingArticles(mapper.listDisplayItem(articlesMetaData: articlesMetaData))
                }
                return
            case .failure(let error):
                self?.viewState.value = .error(error)

            }
        }
    }
}

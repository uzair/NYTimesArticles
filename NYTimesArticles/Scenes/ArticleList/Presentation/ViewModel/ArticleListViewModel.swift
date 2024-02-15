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
    case error(String)
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
  //  var coordinator: Coordinator?
    
    init(getArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor,
         mapper: ArticleListViewModelMapperInterface?) {
        
        self.getArticlesMetaDataUseCase  = getArticlesMetaDataUseCase
        self.mapper = mapper
        
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
        
        if (!Reachability.isConnectedToNetwork()) {
            viewState.value = .error(AppError.noInternet.errorCode)
            return
        }
        
        getArticlesMetaDataUseCase.getArticleList { [weak self] result in
            
            guard let safeSelf = self else {
                return
            }
            
            switch result {
            case .success(let articlesMetaData):
                
                safeSelf.articlesMetaData = articlesMetaData
                if let mapper = safeSelf.mapper {
                    safeSelf.viewState.value = .listingArticles(mapper.listDisplayItem(articlesMetaData: articlesMetaData))
                }
                return
            case .failure(let error):
                if error == .internetNotAvailable{
                    self?.viewState.value = .error(AppError.noInternet.errorCode)
                }else{
                    safeSelf.viewState.value = .error(AppError.failedFetchArticlesMetaData.errorCode)
                }
            }
        }
    }
}

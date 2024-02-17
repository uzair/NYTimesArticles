//
//  ArticleListViewModel.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal enum ArticleListViewState: Equatable {
    case idle
    case loading
    case listingArticles(ArticleListDisplayItem)
    case error(ServiceError)
    
    static func == (lhs: ArticleListViewState, rhs: ArticleListViewState) -> Bool {
          switch (lhs, rhs) {
          case (.idle, .idle), (.loading, .loading):
              return true

          case let (.listingArticles(item1), .listingArticles(item2)):
              return true

          case let (.error(error1), .error(error2)):
              return true

          default:
              return false
          }
      }
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
        
        let urlString = self.articlesMetaData?.results?[index].url
        let nextCoordinator = coordinator?.resolver?.articleDetailCoordinator(urlString: urlString)
        nextCoordinator?.start()
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

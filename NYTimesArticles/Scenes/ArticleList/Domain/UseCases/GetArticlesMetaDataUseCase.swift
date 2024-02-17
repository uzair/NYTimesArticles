//
//  GetArticlesMetaDataUseCases.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

protocol GetArticlesMetaDataUseCaseContractor {
    func getArticleList(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void)
}

final class GetArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor {

    private let repository: ArticleRepositoryContractor
    init(repository: ArticleRepositoryContractor = ArticleRepository()) {
        self.repository = repository
    }

    func getArticleList(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void) {
        repository.getArticlesMetaData(completion: completion)
    }
}


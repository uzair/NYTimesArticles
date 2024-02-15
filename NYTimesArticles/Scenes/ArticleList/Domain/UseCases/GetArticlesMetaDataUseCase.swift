//
//  GetArticlesMetaDataUseCases.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal protocol GetArticlesMetaDataUseCaseContractor {

    func getArticleList(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void)
}

internal final class GetConsentListUseCase: GetArticlesMetaDataUseCaseContractor {

    private let repository: ArticleRepositoryContractor

    init(repository: ArticleRepositoryContractor = ArticleRepository()) {
        self.repository = repository
    }

    func getArticleList(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void) {

        repository.getArticlesMetaData(completion: completion)
    }
}


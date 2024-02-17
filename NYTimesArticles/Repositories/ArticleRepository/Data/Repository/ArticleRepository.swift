//
//  ArticleRepository.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

protocol ArticleRepositoryContractor {
    func getArticlesMetaData(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void)
}

final class ArticleRepository: ArticleRepositoryContractor {

    private let datasource: ArticleRemoteDataSourceContractor
    init(datasource: ArticleRemoteDataSourceContractor = ArticleRemoteDataSource()) {
        self.datasource = datasource
    }
    
    func getArticlesMetaData(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void) {
        datasource.getArticlesMetaData(completion: completion)
    }
    
}

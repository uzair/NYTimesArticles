//
//  ArticleRemoteDataSource.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

protocol ArticleRemoteDataSourceContractor {
    func getArticlesMetaData(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void)
}

final class ArticleRemoteDataSource: ArticleRemoteDataSourceContractor {

    private let serviceManager: ServiceManagerContractor
    init(serviceManager: ServiceManagerContractor = ServiceManager()) {
        self.serviceManager = serviceManager
    }
       
    func getArticlesMetaData(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void) {
        
        let descriptor = ArticlesMetaDataRequestDescriptor()
        serviceManager.performRequest(desriptor: descriptor, completion: completion)

    }
    
}

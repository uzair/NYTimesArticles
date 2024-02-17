//
//  ArticlesMetaDataRequestDescriptor.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

final class ArticlesMetaDataRequestDescriptor: RequestDescriptor {

    private let environment: Environment

    init(environment: Environment = EnvironmentManager.sharedInstance.getEnvironment()) {
        self.environment = environment
    }
    
    var baseURL: URL {
        BaseURLResolver.baseURLFor(environment: environment)
    }
    
    var path: String {
        EndpointPathResolver.EndPointPath.articlesMetadata.rawValue + EndpointPathResolver.apiVersion().rawValue + "/viewed/7.json?api-key=" + EndpointPathResolver.apiKeyFor(environment: environment).rawValue
    }
    
    var method: HTTPMethod {
        .get
    }
    
}

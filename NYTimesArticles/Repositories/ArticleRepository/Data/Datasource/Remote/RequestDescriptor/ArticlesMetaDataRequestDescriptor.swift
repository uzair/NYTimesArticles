//
//  ArticlesMetaDataRequestDescriptor.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal final class ArticlesMetaDataRequestDescriptor: RequestDescriptor {
    
    private let environment: Environment
    private let runtimeConfigurationResolver: RuntimeConfigurationResolvable

    init(environment: Environment = EnvironmentManager.sharedInstance.getEnvironment(), runtimeConfigurationResolver: RuntimeConfigurationResolvable = DependencyInjectionContainer.shared.mandatoryResolve(type: RuntimeConfigurationResolvable.self)) {
        
        self.environment = environment
        self.runtimeConfigurationResolver = runtimeConfigurationResolver
    }
    
    var baseURL: URL {
        BaseURLResolver.baseURLFor(environment: environment)
    }
    
    var path: String {
        EndPointPath.articlesMetadataRequestDescriptor.rawValue + runtimeConfigurationResolver.apiVersion().rawValue + "/viewed/7.json?api-key=" + runtimeConfigurationResolver.apiKeyFor(environment: environment).rawValue
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var encoding: ParameterEncoding {
        JsonEncoding.defaultEncoding
    }
    
    var params: Parameters? {
        nil
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
}

//
//  RuntimeConfiguartionResolvable.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

enum APIVersion: String {
    case v1 = "v1"
    case v2 = "v2"
    case v3 = "3"
}

enum APIKey: String {
    case sandboxKey = "MR95vSebKsGdvB7uIfBDxCSex3GtLevG"
    case productionKey = "MR95vSebKsGdvB7uIfBDxCSex3GtLev"
}

final class EndpointPathResolver {
    
    enum EndPointPath: String {
        case articlesMetadata = "/mostpopular/"
    }

    class func apiKeyFor(environment: Environment) -> APIKey {

        switch environment {
        case .sandbox:
            return .sandboxKey
        case .production:
            return .productionKey
        }
    }

    class func defaultEnvironment() -> Environment {
        return .sandbox
    }
    
    class func apiVersion() -> APIVersion {
        return .v2
    }
}

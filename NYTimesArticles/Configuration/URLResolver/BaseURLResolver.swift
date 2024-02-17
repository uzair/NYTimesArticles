//
//  BaseURLResolver.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

internal class BaseURLResolver {
    
    struct BaseUrl {
        static let sandbox = "https://api.nytimes.com/svc"
        static let production = "https://api.nytimes.com/svc"
    }
    
    class func baseURLFor(environment: Environment) -> URL {
        
        switch environment {
        case .sandbox:
            guard let url = URL(string: BaseUrl.sandbox) else {
                fatalError()
            }
            return url
        case .production:
            guard let url = URL(string: BaseUrl.production) else {
                fatalError()
            }
            return url
        }
    }
}

//
//  RequestDescriptor.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

 protocol RequestDescriptor {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
}



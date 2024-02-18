//
//  JsonEncoding.swift
//  NYTimesArticles
//
//  Created by Macbook on 18/02/2024.
//

import Foundation

protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

final class JsonEncoding: ParameterEncoding {
    
    public static var defaultEncoding: JsonEncoding { return JsonEncoding() }
    
    public func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        
        guard let parameters = parameters else { return urlRequest }
        
        var encodedUrlRequest = urlRequest
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            
            encodedUrlRequest.httpBody = data
        } catch {
            throw ServiceError.parameterEncodingFailed
        }
        
        return encodedUrlRequest
    }
}

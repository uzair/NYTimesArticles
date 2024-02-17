//
//  RequestDescriptorWithSuccessState.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

@testable import NYTimesArticles
import Foundation

struct RequestDescriptorWithSuccessState: RequestDescriptor {
    var baseURL: URL {
        URL(string: ServiceClientConstants.MockedData.mockedBaseURL)!
    }
    
    var path: String {
        ServiceClientConstants.MockedData.mockedPath
    }
    
    var method: HTTPMethod {
        .post
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

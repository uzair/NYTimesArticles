//
//  ServiceClientStubs.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

import Foundation

extension Data {
    static let performRequest_SuccessStub: Data = """
        {
            "name": "\(ServiceClientConstants.MockedData.mockedUsername)",
            "email": "\(ServiceClientConstants.MockedData.mockedEmail)"
        }
        """.data(using: .utf8)!
}

extension Data {
    static let performRequest_errorMessage: Data? = """
        {
            "message": "\(ServiceClientConstants.FailedMessages.requestFailed)"
        }
        """.data(using: .utf8)!
}


extension Data {
    static let performRequest_invalidJsonFormat: Data? = """
        {
            "error": {
                "code": 404
                "message": "Resource not found"
            }
        }
        """.data(using: .utf8)!
}

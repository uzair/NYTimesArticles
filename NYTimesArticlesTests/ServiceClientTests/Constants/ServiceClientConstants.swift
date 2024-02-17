//
//  ServiceClientConstants.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

import Foundation

struct ServiceClientConstants {
    
    // Test data
    struct MockedData {
        static let testExpectation = "Service client request"
        static let mockedUsername: String = "Tarabut SDK"
        static let mockedEmail: String = "tarabut.sdk@example.com"
        static let mockedDomain: String = "Tarabut"
        static let mockedBaseURL = "https://tarabutgateway.com"
        static let mockedPath = "/users"
        
        static let successStatusCode: Int = 200
        static let success202StatusCode: Int = 202
        static let forbiddenStatusCode: Int = 403
    }
    
    // Messages for failed tests
    struct FailedMessages {
        static let requestFailed = "Request failed due to an unknown error."
        static let testPerformRequest_Success_200StatusCode = "ServiceClientTests -> testPerformRequest_Success_200StatusCode(): Expected success but got failure"
        static let testPerformRequest_Success_withEmpyDescriptorHeaders = "ServiceClientTests -> testPerformRequest_Success_withEmpyDescriptorHeaders(): Expected success but got failure"
        static let testPerformRequest_error_requestFailed = "ServiceClientTests -> testPerformRequest_error_requestFailed(): Expected 'requestFailed' but got another type of error"
        static let testPerformRequest_error_internetNotAvailable = "ServiceClientTests -> testPerformRequest_error_internetNotAvailable(): Expected 'internetNotAvailable' but got another type of error"
        static let testPerformRequest_success_statusCode202 = "ServiceClientTests -> testPerformRequest_success_statusCode202(): Test failed."
        static let testPerformRequest_error_unexpectedStatusCode_withErrorMessage = "ServiceClientTests -> testPerformRequest_error_unexpectedStatusCode_withErrorMessage(): Incorrect type of error."
        static let unsuccessful_result_was_expected = "An unsuccessful result was expected."
        static let unsuccessful_result_not_nil_error_expected = "In the case of a fail result, a non-nil error is expected"
    }
}

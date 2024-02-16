//
//  ServiceClientTests.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

import XCTest
@testable import NYTimesArticles

fileprivate typealias mockedData = ServiceClientConstants.MockedData
fileprivate typealias messages = ServiceClientConstants.FailedMessages

final class ServiceClientTests: XCTestCase {

    var serviceClient: ServiceClientContractor!

    override func tearDown() {
        serviceClient = nil
        super.tearDown()
    }
    
    // Successful scenario.
    /// With 200 status code.
    /// Transferred and received all the necessary data.
    /// We check whether the received data correspond to expectations
    func testPerformRequest_Success_200StatusCode() throws {
        // Arrange
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        // Set mock data
        let mockData = Data.performRequest_SuccessStub

        // Return data in handler
        MockURLProtocol.requestHandler = { [weak self] request in
            return (self?.mock200Response, mockData, nil)
        }
        
        serviceClient = ServiceClient(urlSessionConfiguration: configuration)
        let expectation = XCTestExpectation(description: mockedData.testExpectation)
        
        // Act
        serviceClient.performRequest(descriptor: RequestDescriptorWithSuccessState()) { (result: Result<ServiceClientTestsUser, ServiceError>) in
            // Assert
            switch result {
            case .success(let response):
                // Check response values
                XCTAssertEqual(response.name, mockedData.mockedUsername)
            case .failure(let error):
                XCTFail(messages.testPerformRequest_Success_200StatusCode
                        + error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    // Failed scenario.
    /// We are checking a case with an unsuccessful scenario
    /// We check whether the received data correspond to expectations
    func testPerformRequest_error_requestFailed() throws {
        // Arrange
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        // Return data in handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), nil, ServiceError.requestFailed(nil))
        }
        
        serviceClient = ServiceClient(urlSessionConfiguration: configuration)
        let expectation = XCTestExpectation(description: mockedData.testExpectation)
        
        // Act
        serviceClient.performRequest(descriptor: RequestDescriptorWithSuccessState()) { (result: Result<ServiceClientTestsUser, ServiceError>) in
            // Assert
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, ServiceError.requestFailed(nil),
                               messages.testPerformRequest_error_requestFailed)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // Failed scenario.
    /// We are checking a case with an unsuccessful scenario
    /// We got Json in the wrong format, and it caused an json decoding error
    /// We check whether the received data correspond to expectations
    func testPerformRequest_error_jsonDecoding() throws {
        // Arrange
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        // Set mock data
        let mockData = Data.performRequest_errorMessage
        
        // Return data in handler
        MockURLProtocol.requestHandler = { [weak self] request in
            return (self?.mock200Response, mockData, nil)
        }
        
        serviceClient = ServiceClient(urlSessionConfiguration: configuration)
        let expectation = XCTestExpectation(description: mockedData.testExpectation)
        
        // Act
        serviceClient.performRequest(descriptor: RequestDescriptorWithSuccessState()) { (result: Result<ServiceClientTestsUser, ServiceError>) in
            // Assert
            switch result {
            case .success:
                XCTFail(messages.unsuccessful_result_was_expected)
            case .failure(let error):
                XCTAssertNotNil(error, messages.unsuccessful_result_not_nil_error_expected)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // Failed scenario.
    /// We are checking a case with an unsuccessful scenario
    /// We simulate the status of the Internet connection using "Reachability.swizzle"
    /// Thanks to the simulation of the absence of an Internet connection, we check the behavior of "performRequest"
    /// We check whether the received data correspond to expectations
    func testPerformRequest_error_internetNotAvailable() throws {
        // Arrange
        Reachability.swizzle(true)
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        // Return data in handler
        MockURLProtocol.requestHandler = { request in
            throw ServiceError.internetNotAvailable
        }

        serviceClient = ServiceClient(urlSessionConfiguration: configuration)
        let expectation = XCTestExpectation(description: mockedData.testExpectation)

        // Act
        serviceClient.performRequest(descriptor: RequestDescriptorWithSuccessState()) { (result: Result<ServiceClientTestsUser, ServiceError>) in
            // Assert
            switch result {
            case .success:
                XCTFail(messages.unsuccessful_result_was_expected)
            case .failure(let error):
                Reachability.swizzle(false)
                XCTAssertEqual(error, ServiceError.internetNotAvailable,
                               messages.testPerformRequest_error_internetNotAvailable)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
    
    
    // Failed scenario.
    /// With 403 status code.
    /// Received response with  ivalid Json format
    /// We check whether the received error correspond to expectations
    func testPerformRequest_error_unexpectedStatusCode() throws {
        // Arrange
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        // Set mock data
        let mockData = Data.performRequest_invalidJsonFormat

        // Return data in handler
        MockURLProtocol.requestHandler = { [weak self] request in
            return (self?.mock403Response, mockData, nil)
        }

        let serviceClient = ServiceClient(urlSessionConfiguration: configuration)
        let expectation = XCTestExpectation(description: mockedData.testExpectation)

        // Act
        serviceClient.performRequest(descriptor: RequestDescriptorWithSuccessState()) { (result: Result<ServiceClientTestsUser, ServiceError>) in
            // Assert
            switch result {
            case .success:
                XCTFail(messages.unsuccessful_result_was_expected)
            case .failure(let error):
                XCTAssertNotNil(error, messages.unsuccessful_result_not_nil_error_expected)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}

fileprivate extension ServiceClientTests {
    var mock200Response: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: mockedData.mockedBaseURL)!,
                                           statusCode: mockedData.successStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
    }
    
    var mock403Response: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: mockedData.mockedBaseURL)!,
                                           statusCode: mockedData.forbiddenStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
    }

}

//
//  ArticleRepositoryTests.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

import XCTest
@testable import NYTimesArticles

final class ArticleRepositoryTests: XCTestCase {
    
    private var articleRepo: ArticleRepositoryContractor!
    
    override func tearDown() {
        articleRepo = nil
        super.tearDown()
    }
    
    // Successful scenario.
    /// With 200 status code.
    /// Transferred and received all the necessary data.
    /// Сheck whether the received data correspond to expectations
    func testGetArticlesMetaData_successfulCall() {
        
        // Expectation
        let expectation = XCTestExpectation(description: "testGetArticlesMetaData_successfulCall")
        
        // Given
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        
        let mockServiceClient = ServiceClient(urlSessionConfiguration: configuration)
        let mockServiceManager = ServiceManager(serviceClient: mockServiceClient)
        let articleRemoteDataSource = ArticleRemoteDataSource(serviceManager: mockServiceManager)
        
        let articleRepo = ArticleRepository(datasource: articleRemoteDataSource)
        
        // Set mock data
        let mockData = try! JSONEncoder().encode(ArticlesMetaData())
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, nil)
            
        }
        
        articleRepo.getArticlesMetaData { (cResult: Result<ArticlesMetaData, ServiceError>) in
            
            switch cResult {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail()
            }
            
        }
        
    }
    
    // Failed scenario.
    /// We are checking a case with an unsuccessful scenario
    /// Check whether the received data correspond to expectations
    func testGetArticlesMetaData_failureCall() {
        
        // Expectation
        let expectation = XCTestExpectation(description: "testGetArticlesMetaData_failureCall")
        
        // Given
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        
        let mockServiceClient = ServiceClient(urlSessionConfiguration: configuration)
        let mockServiceManager = ServiceManager(serviceClient: mockServiceClient)
        let articleRemoteDataSource = ArticleRemoteDataSource(serviceManager: mockServiceManager)
        
        let articleRepo = ArticleRepository(datasource: articleRemoteDataSource)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), nil, ServiceError.requestFailed(nil))
            
        }
        
        articleRepo.getArticlesMetaData { (cResult: Result<ArticlesMetaData, ServiceError>) in
            
            switch cResult {
            case .success(let response):
                XCTFail()
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .requestFailed(nil))
                expectation.fulfill()
            }
            
        }
        
    }
}

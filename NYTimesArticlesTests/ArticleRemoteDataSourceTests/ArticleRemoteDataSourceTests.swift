//
//  ArticleRemoteDataSourceTests.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

import XCTest
@testable import NYTimesArticles

final class ArticleRemoteDataSourceTests: XCTestCase {
    
    private var articleRemoteDataSource: ArticleRemoteDataSourceContractor!
    
    override func tearDown() {
        articleRemoteDataSource = nil
        super.tearDown()
    }
    
    // Successful scenario
    func testGetArticlesMetaData_successfulCall() {
        
        // Expectation
        let expectation = XCTestExpectation(description: "testDataSourceGetArticlesMetaData_successfulCall")
        
        // Given
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        
        let mockServiceClient = ServiceClient(urlSessionConfiguration: configuration)
        let mockServiceManager = ServiceManager(serviceClient: mockServiceClient)
        let articleRemoteDataSource = ArticleRemoteDataSource(serviceManager: mockServiceManager)
        
        // Set mock data
        let mockData = try! JSONEncoder().encode(ArticlesMetaData())
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, nil)
            
        }
        
        articleRemoteDataSource.getArticlesMetaData { (cResult: Result<ArticlesMetaData, ServiceError>) in
            
            switch cResult {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail()
            }
            
        }
        
    }
    
    // Failed scenario
    func testGetArticlesMetaData_failureCall() {
        
        // Expectation
        let expectation = XCTestExpectation(description: "testDataSourceGetArticlesMetaData_failureCall")
        
        // Given
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        
        let mockServiceClient = ServiceClient(urlSessionConfiguration: configuration)
        let mockServiceManager = ServiceManager(serviceClient: mockServiceClient)
        let articleRemoteDataSource = ArticleRemoteDataSource(serviceManager: mockServiceManager)
                
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), nil, ServiceError.requestFailed(nil))
            
        }
        
        articleRemoteDataSource.getArticlesMetaData { (cResult: Result<ArticlesMetaData, ServiceError>) in
            
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

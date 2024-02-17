//
//  GetArticlesMetaDataUseCaseTests.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

import XCTest
@testable import NYTimesArticles

final class GetArticlesMetaDataUseCaseTests: XCTestCase {
    
    private var getArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor!
    
    override func tearDown() {
        getArticlesMetaDataUseCase = nil
        super.tearDown()
    }
    
    func testGetArticlesMetaDataUseCase_Success() {
        
        // Expectation
        let expectation = XCTestExpectation(description: "testGetArticlesMetaDataUseCase_Success")
        
        // Given
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        
        let mockServiceClient = ServiceClient(urlSessionConfiguration: configuration)
        let mockServiceManager = ServiceManager(serviceClient: mockServiceClient)
        let articleRemoteDataSource = ArticleRemoteDataSource(serviceManager: mockServiceManager)
        
        let articleRepo = ArticleRepository(datasource: articleRemoteDataSource)
        let getArticlesMetaDataUseCase = GetArticlesMetaDataUseCase(repository: articleRepo)
        
        // Set mock data
        let mockData = try! JSONEncoder().encode(ArticlesMetaData())
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, nil)
            
        }
        
        getArticlesMetaDataUseCase.getArticleList { (cResult: Result<ArticlesMetaData, ServiceError>) in
            
            switch cResult {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail()
            }
            
        }
    }
    
    func testGetArticlesMetaDataUseCase_Failure() {
        
        // Expectation
        let expectation = XCTestExpectation(description: "testGetArticlesMetaDataUseCase_Failure")
        
        // Given
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        
        let mockServiceClient = ServiceClient(urlSessionConfiguration: configuration)
        let mockServiceManager = ServiceManager(serviceClient: mockServiceClient)
        let articleRemoteDataSource = ArticleRemoteDataSource(serviceManager: mockServiceManager)
        
        let articleRepo = ArticleRepository(datasource: articleRemoteDataSource)
        let getArticlesMetaDataUseCase = GetArticlesMetaDataUseCase(repository: articleRepo)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), nil, ServiceError.requestFailed(nil))
            
        }
        
        getArticlesMetaDataUseCase.getArticleList { (cResult: Result<ArticlesMetaData, ServiceError>) in
            
            switch cResult {
            case .success(let response):
                XCTFail()
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertNotNil(failure)
                XCTAssertEqual(failure, .requestFailed(nil))
            }
            
        }
    }
    
}

//
//  ArticlesMetaDataRequestDescriptorTests.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 16/02/2024.
//

import XCTest
@testable import NYTimesArticles

fileprivate typealias mockedData = ArticlesMetaDataRequestDecriptorConstants.MockedData

final class ArticlesMetaDataRequestDescriptorTests: XCTestCase {

    var articlesMetaDataRequestDescriptor: ArticlesMetaDataRequestDescriptor!
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        articlesMetaDataRequestDescriptor = nil
        super.tearDown()
    }

    override func setUp() {
        super.setUp()
        
        articlesMetaDataRequestDescriptor = ArticlesMetaDataRequestDescriptor(environment: .sandbox)
    }
  
    func testBaseUrl() {
        XCTAssertEqual(articlesMetaDataRequestDescriptor.baseURL, URL(string: mockedData.baseUrl))
    }
    
    func testPath() {
        XCTAssertEqual(articlesMetaDataRequestDescriptor.path, mockedData.path)
    }

    func testMethod() {
        XCTAssertEqual(articlesMetaDataRequestDescriptor.method, .get)
    }
}

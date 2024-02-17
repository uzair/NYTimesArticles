//
//  ArticleDetailsViewModelTests.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 17/02/2024.
//

import XCTest
@testable import NYTimesArticles

final class ArticleDetailViewModelTests: XCTestCase {

    private var articleDetailViewModel: ArticleDetailViewModelContractor!
    
    override func tearDown() {
        super.tearDown()
        articleDetailViewModel = nil
    }

    func testOnViewLoadUpdatesViewState() {
        // Given
        let viewModel = ArticleDetailViewModel(articleUrl: "https://example.com", coordinator: nil)

        // When
        viewModel.onViewLoad()

        // Then
        XCTAssertEqual(viewModel.viewState.value, .loadingUrl("https://example.com"))
    }

    func testIdleStateOnInitialization() {
        
        // Given , When
        let viewModel = ArticleDetailViewModel(articleUrl: "https://example.com", coordinator: nil)
        
        // Then
        XCTAssertEqual(viewModel.viewState.value, .idle)
        
    }
    
    func testTwoDifferentStatesReturnFalse() {
        
        // Given
        let viewModel = ArticleDetailViewModel(articleUrl: "https://example.com", coordinator: nil)

        // When
        viewModel.onViewLoad()

        // Then
        XCTAssertNotEqual(viewModel.viewState.value, .idle)
        
    }
}

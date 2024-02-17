//
//  ArticleListViewModelTests.swift
//  NYTimesArticlesTests
//
//  Created by Macbook on 17/02/2024.
//

import XCTest
@testable import NYTimesArticles


// MARK: - Mock Classes

final class MockGetArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor {
    var getArticleListCalled = false

    func getArticleList(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void) {
        getArticleListCalled = true
        // Simulate a response for testing
        completion(.success(ArticlesMetaData(results: [])))
    }
}

final class MockErrorGetArticlesMetaDataUseCase: GetArticlesMetaDataUseCaseContractor {
    
    func getArticleList(completion: @escaping (Result<ArticlesMetaData, ServiceError>) -> Void) {
        // Simulate a response for testing
        completion(.failure(ServiceError.requestFailed(nil)))
    }
}

final class MockViewModelMapper: ArticleListViewModelMapperInterface {
    var listDisplayItemCalled = false

    func listDisplayItem(articlesMetaData: ArticlesMetaData) -> ArticleListDisplayItem {
        listDisplayItemCalled = true
        // Simulate a display item for testing
        return ArticleListDisplayItem(cellDisplayItems: [], title: "")
    }
}

final class MockCoordinatorResolver: CoordinatorResolverContractor {
    var navigationController: UINavigationController?
    
    func articleListCoordinator() -> Coordinator? {
        let mockCoordinator = MockCoordinator.shared
        mockCoordinator.resolver = self
        return mockCoordinator
    }
    
    func articleDetailCoordinator(urlString: String?) -> Coordinator? {
        let mockCoordinator = MockCoordinator.shared
        mockCoordinator.resolver = self
        return mockCoordinator
    }
}

final class MockCoordinator: Coordinator {
    
    static let shared = MockCoordinator()
    
    var resolver: CoordinatorResolverContractor?
    var startCalled = false
    
    init(resolver: CoordinatorResolverContractor? = MockCoordinatorResolver(), startCalled: Bool = false) {
        self.resolver = resolver
        self.startCalled = startCalled
    }
    
    func start() {
        startCalled = true
    }
}

//final class MockArticleListCoordinator: Coordinator {
//    var resolver: CoordinatorResolver
//    var startCalled: Bool
//    
//    init(resolver: CoordinatorResolver = CoordinatorResolver(), startCalled: Bool = false) {
//        self.resolver = resolver
//        self.startCalled = startCalled
//    }
//    
//    func start() {
//        startCalled = true
//    }
//}



final class ArticleListViewModelTests: XCTestCase {
    
    private var articleListViewModel: ArticleListViewModelContractor!
    
    override func tearDown() {
        articleListViewModel = nil
        super.tearDown()
    }
    
    // MARK: - Tests

      func testOnViewLoadCallsLoadArticlesMetaData() {
          // Given
          let mockUseCase = MockGetArticlesMetaDataUseCase()
          articleListViewModel = ArticleListViewModel(getArticlesMetaDataUseCase: mockUseCase, mapper: nil, coordinator: nil)

          // When
          articleListViewModel.onViewLoad()

          // Then
          XCTAssertTrue(mockUseCase.getArticleListCalled)
      }
    
    func testOnViewLoadUpdatesViewState() {
          // Given
          let mockUseCase = MockGetArticlesMetaDataUseCase()
          articleListViewModel = ArticleListViewModel(getArticlesMetaDataUseCase: mockUseCase, mapper: nil, coordinator: nil)

          // When
            articleListViewModel.onViewLoad()

          // Then
        XCTAssertEqual(articleListViewModel.viewState.value, .loading, "onViewLoad should update viewState to .loading")
      }
    
    func testOnLoadArticlesMetaDataSuccess() {
            // Given
            let mockUseCase = MockGetArticlesMetaDataUseCase()
            let mockMapper = MockViewModelMapper()
            articleListViewModel = ArticleListViewModel(getArticlesMetaDataUseCase: mockUseCase, mapper: mockMapper, coordinator: nil)

            // When
        articleListViewModel.onViewLoad()

            // Then
            XCTAssertTrue(mockMapper.listDisplayItemCalled)
            XCTAssertEqual(articleListViewModel.viewState.value, .listingArticles(ArticleListDisplayItem(cellDisplayItems: [], title: "")))
        }

    
        func testOnLoadArticlesMetaDataFailure() {
            // Given
            let mockUseCase = MockErrorGetArticlesMetaDataUseCase()
            articleListViewModel = ArticleListViewModel(getArticlesMetaDataUseCase: mockUseCase, mapper: nil, coordinator: nil)

            // When
            
            articleListViewModel.onViewLoad()

            // Then
            XCTAssertEqual(articleListViewModel.viewState.value, .error(ServiceError.requestFailed(nil)))
        }

    
        func testOnClickListItemAt() {
            // Given
            let mockCoordinator = MockCoordinator()
            articleListViewModel = ArticleListViewModel(getArticlesMetaDataUseCase: MockGetArticlesMetaDataUseCase(), mapper: nil, coordinator: mockCoordinator)

            // When
            articleListViewModel.onClickListItemAt(index: 0)

            // Then
            let nextCoordinator = mockCoordinator.resolver?.articleDetailCoordinator(urlString: "") as! MockCoordinator
            XCTAssertNotNil(nextCoordinator)
            XCTAssertTrue(nextCoordinator.startCalled)
        }
    
    
}


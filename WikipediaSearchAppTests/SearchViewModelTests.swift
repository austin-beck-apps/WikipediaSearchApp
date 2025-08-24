//
//  SearchViewModelTests.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/24/25.
//

import XCTest
import Combine
import CoreLocation
@testable import WikipediaSearchApp

class MockWikipediaService: WikipediaServiceProtocol {
    var mockArticles: [WikipediaPage] = []
    var shouldFail = false
    
    func searchArticles(query: String) -> AnyPublisher<[WikipediaPage], Error> {
        if shouldFail {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        return Just(mockArticles)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func searchNearbyArticles(coordinate: CLLocationCoordinate2D, radius: Int) -> AnyPublisher<[WikipediaPage], Error> {
        if shouldFail {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        return Just(mockArticles)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

@MainActor
class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    var mockService: MockWikipediaService!
    
    override func setUp() {
        super.setUp()
        mockService = MockWikipediaService()
        viewModel = SearchViewModel(wikipediaService: mockService)
    }
    
    func testSearchArticlesSuccess() {
        let mockArticle = WikipediaPage(
            pageid: 1,
            title: "Test Article",
            extract: "Test extract",
            thumbnail: nil,
            coordinates: nil,
            missing: nil,
            invalid: nil
        )
        mockService.mockArticles = [mockArticle]
        
        viewModel.searchArticles(query: "test")
        
        let expectation = XCTestExpectation(description: "Articles loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.articles.count, 1)
            XCTAssertEqual(self.viewModel.articles.first?.title, "Test Article")
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testSearchArticlesWithMissingPages() {
        let validArticle = WikipediaPage(
            pageid: 1,
            title: "Valid Article",
            extract: "Valid extract",
            thumbnail: nil,
            coordinates: nil,
            missing: nil,
            invalid: nil
        )
        
        let missingArticle = WikipediaPage(
            pageid: nil,
            title: "Missing Article",
            extract: nil,
            thumbnail: nil,
            coordinates: nil,
            missing: true,
            invalid: nil
        )
        
        mockService.mockArticles = [validArticle, missingArticle]
        
        viewModel.searchArticles(query: "test")
        
        let expectation = XCTestExpectation(description: "Articles filtered")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Should only return valid articles (missing pages filtered out)
            XCTAssertEqual(self.viewModel.articles.count, 1)
            XCTAssertEqual(self.viewModel.articles.first?.title, "Valid Article")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}

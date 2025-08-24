//
//  WikipediaServiceTests.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/24/25.
//
import XCTest
import Combine
@testable import WikipediaSearchApp

class WikipediaServiceTests: XCTestCase {
    var service: WikipediaService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        service = WikipediaService()
        cancellables = Set<AnyCancellable>()
    }
    
    func testSearchArticles() {
        let expectation = XCTestExpectation(description: "Search articles")
        
        service.searchArticles(query: "Swift programming")
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Search failed: \(error)")
                    }
                },
                receiveValue: { articles in
                    XCTAssertFalse(articles.isEmpty, "Should return articles")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}

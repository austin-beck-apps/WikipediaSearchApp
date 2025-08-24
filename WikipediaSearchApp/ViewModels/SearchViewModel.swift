//
//  SearchViewModel.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import SwiftUI
import Combine
import CoreLocation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var articles: [WikipediaPage] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchType: SearchType?
    
    private let wikipediaService: WikipediaServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(wikipediaService: WikipediaServiceProtocol = WikipediaService()) {
        self.wikipediaService = wikipediaService
        setupSearchTextBinding()
    }
    
    func searchWhenLocationAvailable(from locationManager: LocationManager) {
        if let location = locationManager.location {
            searchNearbyArticles(coordinate: location)
        } else {
            // Subscribe to location updates
            locationManager.$location
                .compactMap { $0 }
                .first()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] location in
                    self?.searchNearbyArticles(coordinate: location)
                }
                .store(in: &cancellables)
        }
    }
    
    private func setupSearchTextBinding() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                if !searchText.isEmpty {
                    self?.searchArticles(query: searchText)
                }
            }
            .store(in: &cancellables)
    }
    
    func searchArticles(query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        searchType = .text(query)
        
        wikipediaService.searchArticles(query: query)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] articles in
                    self?.articles = articles
                }
            )
            .store(in: &cancellables)
    }
    
    func searchNearbyArticles(coordinate: CLLocationCoordinate2D) {
        isLoading = true
        errorMessage = nil
        searchType = .location(coordinate)
        
        wikipediaService.searchNearbyArticles(coordinate: coordinate, radius: 200)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] articles in
                    self?.articles = articles
                }
            )
            .store(in: &cancellables)
    }
    
    func clearSearch() {
        articles = []
        searchText = ""
        searchType = nil
        errorMessage = nil
    }
}


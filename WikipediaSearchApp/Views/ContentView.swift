//
//  ContentView.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var showingMapView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchHeaderView(
                    searchText: $searchViewModel.searchText,
                    onLocationSearch: handleLocationSearch,
                    onToggleMap: { showingMapView.toggle() },
                    isLocationLoading: locationManager.isLoading,
                    showingMapView: showingMapView
                )
                
                if showingMapView {
                    MapView(articles: searchViewModel.articles)
                        .transition(.slide)
                } else {
                    ArticleListView(
                        articles: searchViewModel.articles,
                        isLoading: searchViewModel.isLoading,
                        errorMessage: searchViewModel.errorMessage
                    )
                    .transition(.slide)
                }
            }
            .navigationTitle("Wikipedia Search")
            .navigationBarTitleDisplayMode(.large)
            .animation(.easeInOut(duration: 0.3), value: showingMapView)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func handleLocationSearch() {
        locationManager.requestLocation()
        searchViewModel.searchWhenLocationAvailable(from: locationManager)
    }
}

#Preview {
    ContentView()
}

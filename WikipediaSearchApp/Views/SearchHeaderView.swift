//
//  SearchHeaderView.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import SwiftUI

struct SearchHeaderView: View {
    @Binding var searchText: String
    let onLocationSearch: () -> Void
    let onToggleMap: () -> Void
    let isLocationLoading: Bool
    let showingMapView: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search Wikipedia articles...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                if !searchText.isEmpty {
                    Button("Clear") {
                        searchText = ""
                    }
                    .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            HStack {
                Button(action: onLocationSearch) {
                    HStack {
                        if isLocationLoading {
                            ProgressView()
                                .scaleEffect(0.8)
                        } else {
                            Image(systemName: "location")
                        }
                        Text("Near Me")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .disabled(isLocationLoading)
                
                Spacer()
                
                Button(action: onToggleMap) {
                    HStack {
                        Image(systemName: showingMapView ? "list.bullet" : "map")
                        Text(showingMapView ? "List" : "Map")
                    }
                    .foregroundColor(.blue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
        .background(Color(.systemBackground))
    }
}

#Preview("Default State") {
    SearchHeaderView(
        searchText: .constant(""),
        onLocationSearch: {},
        onToggleMap: {},
        isLocationLoading: false,
        showingMapView: false
    )
}

#Preview("With Search Text") {
    SearchHeaderView(
        searchText: .constant("Test Query"),
        onLocationSearch: {},
        onToggleMap: {},
        isLocationLoading: false,
        showingMapView: false
    )
}

#Preview("Loading Location") {
    SearchHeaderView(
        searchText: .constant(""),
        onLocationSearch: {},
        onToggleMap: {},
        isLocationLoading: true,
        showingMapView: false
    )
}

#Preview("Map View Mode") {
    SearchHeaderView(
        searchText: .constant(""),
        onLocationSearch: {},
        onToggleMap: {},
        isLocationLoading: false,
        showingMapView: true
    )
}

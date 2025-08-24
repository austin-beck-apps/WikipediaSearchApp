//
//  MapView.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    let articles: [WikipediaPage]
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var body: some View {
        ZStack {
            if articles.isEmpty {
                VStack {
                    Image(systemName: "map")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("No locations to display")
                        .font(.headline)
                        .padding(.top, 4)
                    Text("Search for articles to see them on the map")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGray6))
            } else {
                Map(position: $cameraPosition) {
                    ForEach(articlesWithLocations) { article in
                        Annotation(article.title, coordinate: article.location!) {
                            VStack {
                                AsyncImage(url: URL(string: article.thumbnail?.source ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Circle()
                                        .fill(Color.blue)
                                        .overlay(
                                            Image(systemName: "location")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                        )
                                }
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(radius: 3)
                                
                                Text(article.title)
                                    .font(.caption2)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 2)
                                    .background(Color.white)
                                    .cornerRadius(4)
                                    .shadow(radius: 2)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .onAppear {
                    updateMapRegion()
                }
                .onChange(of: articles) {
                    updateMapRegion()
                }
            }
        }
    }
    
    private var articlesWithLocations: [WikipediaPage] {
        articles.filter { $0.location != nil }
    }
    
    private func updateMapRegion() {
        let locations = articlesWithLocations.compactMap { $0.location }
        guard !locations.isEmpty else { return }
        
        let latitudes = locations.map { $0.latitude }
        let longitudes = locations.map { $0.longitude }
        
        let minLat = latitudes.min() ?? 0
        let maxLat = latitudes.max() ?? 0
        let minLon = longitudes.min() ?? 0
        let maxLon = longitudes.max() ?? 0
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: max(maxLat - minLat, 0.01) * 1.3,
            longitudeDelta: max(maxLon - minLon, 0.01) * 1.3
        )
        
        withAnimation(.easeInOut(duration: 0.5)) {
            cameraPosition = .region(MKCoordinateRegion(center: center, span: span))
        }
    }
}

#Preview("Empty Map") {
    MapView(articles: [])
}

#Preview("Map with Articles") {
    MapView(articles: PreviewData.sampleArticles)
}


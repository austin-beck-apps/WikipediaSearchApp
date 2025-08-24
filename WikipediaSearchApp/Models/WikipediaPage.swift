//
//  WikipediaPage.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import Foundation
import CoreLocation

struct WikipediaPage: Codable, Identifiable, Equatable {
    let pageid: Int?
    let title: String
    let extract: String?
    let thumbnail: Thumbnail?
    let coordinates: [Coordinate]?
    
    // Handle cases where some pages might be missing or have different structure
    let missing: Bool?
    let invalid: Bool?
    
    var id: Int { pageid ?? abs(title.hashValue) }
    
    static func == (lhs: WikipediaPage, rhs: WikipediaPage) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.extract == rhs.extract &&
               lhs.thumbnail?.source == rhs.thumbnail?.source &&
               lhs.coordinates?.first?.lat == rhs.coordinates?.first?.lat &&
               lhs.coordinates?.first?.lon == rhs.coordinates?.first?.lon
    }
    
    struct Thumbnail: Codable, Equatable {
        let source: String
        let width: Int?
        let height: Int?
    }
    
    struct Coordinate: Codable, Equatable {
        let lat: Double
        let lon: Double
    }
    
    var location: CLLocationCoordinate2D? {
        guard let coord = coordinates?.first else { return nil }
        return CLLocationCoordinate2D(latitude: coord.lat, longitude: coord.lon)
    }
    
    var wikipediaURL: URL? {
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? title
        return URL(string: "https://en.wikipedia.org/wiki/\(encodedTitle)")
    }
}

//
//  WikipediaServiceProtocol.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import Combine
import CoreLocation

protocol WikipediaServiceProtocol {
    func searchArticles(query: String) -> AnyPublisher<[WikipediaPage], Error>
    func searchNearbyArticles(coordinate: CLLocationCoordinate2D, radius: Int) -> AnyPublisher<[WikipediaPage], Error>
}

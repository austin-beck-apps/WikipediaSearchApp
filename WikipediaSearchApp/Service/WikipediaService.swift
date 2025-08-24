//
//  WikipediaService.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import Combine
import CoreLocation

class WikipediaService: WikipediaServiceProtocol {
    private let session = URLSession.shared
    private let baseURL = "https://en.wikipedia.org/w/api.php"
    private let userAgent = "WikipediaSearchApp/1.0 (contact@example.com)"
    
    func searchArticles(query: String) -> AnyPublisher<[WikipediaPage], Error> {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "generator", value: "search"),
            URLQueryItem(name: "gsrsearch", value: query),
            URLQueryItem(name: "gsrlimit", value: "20"),
            URLQueryItem(name: "prop", value: "extracts|pageimages|coordinates"),
            URLQueryItem(name: "exintro", value: "1"),
            URLQueryItem(name: "explaintext", value: "1"),
            URLQueryItem(name: "exsentences", value: "3"),
            URLQueryItem(name: "piprop", value: "thumbnail"),
            URLQueryItem(name: "pithumbsize", value: "200"),
            URLQueryItem(name: "coprop", value: "name"),
            URLQueryItem(name: "formatversion", value: "2")
        ]
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                // Debug: Print raw response for troubleshooting
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw API Response: \(jsonString.prefix(500))")
                }
                return data
            }
            .decode(type: WikipediaSearchResponse.self, decoder: JSONDecoder())
            .map { response in
                let pages = response.pages
                print("Decoded \(pages.count) pages successfully")
                return pages
            }
            .eraseToAnyPublisher()
    }
    
    func searchNearbyArticles(coordinate: CLLocationCoordinate2D, radius: Int = 10000) -> AnyPublisher<[WikipediaPage], Error> {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "generator", value: "geosearch"),
            URLQueryItem(name: "ggscoord", value: "\(coordinate.latitude)|\(coordinate.longitude)"),
            URLQueryItem(name: "ggsradius", value: "\(radius)"),
            URLQueryItem(name: "ggslimit", value: "20"),
            URLQueryItem(name: "prop", value: "extracts|pageimages|coordinates"),
            URLQueryItem(name: "exintro", value: "1"),
            URLQueryItem(name: "explaintext", value: "1"),
            URLQueryItem(name: "exsentences", value: "3"),
            URLQueryItem(name: "piprop", value: "thumbnail"),
            URLQueryItem(name: "pithumbsize", value: "200"),
            URLQueryItem(name: "coprop", value: "name"),
            URLQueryItem(name: "formatversion", value: "2")
        ]
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                // Debug: Print raw response for troubleshooting
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw API Response: \(jsonString.prefix(500))")
                }
                return data
            }
            .decode(type: WikipediaSearchResponse.self, decoder: JSONDecoder())
            .map { response in
                let pages = response.pages
                print("Decoded \(pages.count) pages successfully")
                return pages
            }
            .eraseToAnyPublisher()
    }
}

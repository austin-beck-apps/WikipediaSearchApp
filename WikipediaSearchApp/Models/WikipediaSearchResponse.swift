//
//  WikipediaSearchResponse.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import Foundation

struct WikipediaSearchResponse: Codable {
    let query: Query?
    let batchcomplete: Bool?
    
    struct Query: Codable {
        let pages: [WikipediaPage]?
    }
    
    var pages: [WikipediaPage] {
        let allPages = query?.pages ?? []
        // Filter out missing or invalid pages
        return allPages.filter { page in
            page.missing != true && page.invalid != true && page.pageid != nil
        }
    }
}

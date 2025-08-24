//
//  SearchType.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import Foundation
import CoreLocation

enum SearchType {
    case text(String)
    case location(CLLocationCoordinate2D)
}

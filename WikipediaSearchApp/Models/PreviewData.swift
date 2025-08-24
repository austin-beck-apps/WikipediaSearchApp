//
//  PreviewData.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/24/25.
//
import SwiftUI

struct PreviewData {
    static let sampleArticles: [WikipediaPage] = [
        WikipediaPage(
            pageid: 1,
            title: "Swift (programming language)",
            extract: "Swift is a general-purpose, multi-paradigm, compiled programming language developed by Apple Inc. and the open-source community. First released in 2014, Swift was developed as a replacement for Apple's earlier programming language Objective-C.",
            thumbnail: WikipediaPage.Thumbnail(
                source: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/200px-Swift_logo.svg.png",
                width: 200,
                height: 200
            ),
            coordinates: [
                WikipediaPage.Coordinate(lat: 37.3861, lon: -122.0839)
            ],
            missing: nil,
            invalid: nil
        ),
        WikipediaPage(
            pageid: 2,
            title: "Computer Science",
            extract: "Computer science is the study of algorithms and data structures, computational systems, and the design of computer systems and their applications.",
            thumbnail: nil,
            coordinates: nil,
            missing: nil,
            invalid: nil
        ),
        WikipediaPage(
            pageid: 3,
            title: "Stanford University",
            extract: "Stanford University is a private research university in Stanford, California. Stanford was founded in 1885 by Leland and Jane Stanford in memory of their only child, Leland Stanford Jr.",
            thumbnail: WikipediaPage.Thumbnail(
                source: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Seal_of_Stanford_University.svg/200px-Seal_of_Stanford_University.svg.png",
                width: 200,
                height: 200
            ),
            coordinates: [
                WikipediaPage.Coordinate(lat: 37.4275, lon: -122.1697)
            ],
            missing: nil,
            invalid: nil
        ),
        WikipediaPage(
            pageid: 4,
            title: "Golden Gate Bridge",
            extract: "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.",
            thumbnail: WikipediaPage.Thumbnail(
                source: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/GoldenGateBridge-001.jpg/200px-GoldenGateBridge-001.jpg",
                width: 200,
                height: 133
            ),
            coordinates: [
                WikipediaPage.Coordinate(lat: 37.8199, lon: -122.4783)
            ],
            missing: nil,
            invalid: nil
        )
    ]
}

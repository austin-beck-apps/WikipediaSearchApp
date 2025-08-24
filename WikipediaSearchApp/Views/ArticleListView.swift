//
//  ArticleListView.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [WikipediaPage]
    let isLoading: Bool
    let errorMessage: String?
    
    var body: some View {
        ZStack {
            if isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("Searching...")
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text("Error")
                        .font(.headline)
                        .padding(.top, 4)
                    Text(errorMessage)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if articles.isEmpty {
                VStack {
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("Start Searching")
                        .font(.headline)
                        .padding(.top, 4)
                    Text("Enter a search term or tap 'Near Me' to find articles")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(articles) { article in
                    ArticleRowView(article: article)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

#Preview("Loading State") {
    ArticleListView(
        articles: [],
        isLoading: true,
        errorMessage: nil
    )
}

#Preview("Error State") {
    ArticleListView(
        articles: [],
        isLoading: false,
        errorMessage: "Network connection failed. Please check your internet connection and try again."
    )
}

#Preview("Empty State") {
    ArticleListView(
        articles: [],
        isLoading: false,
        errorMessage: nil
    )
}

#Preview("With Articles") {
    ArticleListView(
        articles: PreviewData.sampleArticles,
        isLoading: false,
        errorMessage: nil
    )
}

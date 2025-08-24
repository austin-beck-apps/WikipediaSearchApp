//
//  ArticleRowView.swift
//  WikipediaSearchApp
//
//  Created by Austin Beck on 8/23/25.
//

import SwiftUI

struct ArticleRowView: View {
    let article: WikipediaPage
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: article.thumbnail?.source ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.secondary)
                    )
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                
                if let extract = article.extract {
                    Text(extract)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
                
                HStack {
                    if let location = article.location {
                        HStack(spacing: 2) {
                            Image(systemName: "location")
                                .font(.caption2)
                            Text("\(location.latitude, specifier: "%.2f"), \(location.longitude, specifier: "%.2f")")
                                .font(.caption2)
                        }
                        .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    if let url = article.wikipediaURL {
                        Link(destination: url) {
                            Text("Read More")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(4)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview("Article with Image") {
    ArticleRowView(article: PreviewData.sampleArticles[0])
        .padding()
}

#Preview("Article without Image") {
    ArticleRowView(article: PreviewData.sampleArticles[1])
        .padding()
}

#Preview("Article with Location") {
    ArticleRowView(article: PreviewData.sampleArticles[2])
        .padding()
}


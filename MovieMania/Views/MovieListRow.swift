// CategoryRow.swift
// MovieMania
//
// Created by Joben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//


import SwiftUI

struct MovieListRow: View {
  var collectionName: String
  var movies: [Movie]
  var showDate: Bool = true
  var isInset: Bool = false
  
  var body: some View {
    VStack(alignment: .leading) {
      if isInset {
        Text(collectionName.uppercased())
          .font(.callout)
          .foregroundStyle(.secondary)
      } else {
        Text(collectionName)
          .font(.headline)
          .padding(.leading, 15)
          .padding(.top, 5)
      }
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 0) {
          ForEach(movies.sorted(by: { $0.releaseDate < $1.releaseDate })) { movie in
            NavigationLink {
              MovieDetail(movie: movie)
            } label: {
              MovieItem(movie: movie, showDate: showDate)
            }
            .buttonStyle(.plain)
          }
        }
      }
      .frame(height: 185)
    }
  }
}

#Preview {
  let genre: Genre = .family
  let movies = ModelData().moviesByGenre[genre.rawValue]!
  
  NavigationStack {
    MovieListRow(collectionName: genre.rawValue, movies: movies)
      .environment(Profile.default)
  }
}

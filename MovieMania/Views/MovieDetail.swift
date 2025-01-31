// MovieDetail.swift
// MovieMania
//
// Created by Joben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

struct MovieDetail : View {
  @Environment(Profile.self) var profile
  
  var movie: Movie
  var isFavorite: Bool { profile.favoriteMovies.contains(movie) }
  
  @State private var showOverview: Bool = false
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Text(movie.title)
          .font(.title.bold())
        
        Text("RELEASED IN THEATERS")
          .font(.caption)
          .foregroundStyle(.secondary)
        
        Text(movie.releaseDate, style: .date)
          .font(.headline)

        ZStack {
          movie.posterImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
          
          if showOverview {
            Rectangle()
              .background(Material.ultraThin)
              .cornerRadius(8)
            
            VStack(alignment: .leading) {
              Text("GENRE")
                .font(.caption)
                .foregroundStyle(.secondary)
              
              Text(movie.genre.emoji + " " + movie.genre.rawValue)
              
              Text("RATING AVERAGE")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.top, 8)
              
              Text(movie.voteAverage, format: .percent)
              
              Text("OVERVIEW")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.top, 8)
              
              Text(movie.overview)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
              
              Spacer()
            }
            .foregroundStyle(.white)
            .padding()
          }
        }
        .onTapGesture {
          withAnimation {
            showOverview.toggle()
          }
        }
      }
      .padding(.horizontal)
      .toolbar {
        Button {
          profile.setFavorite(for: movie)
        } label: {
          Image(systemName: isFavorite ? "star.fill" : "star")
        }
      }
    }
  }
}

#Preview {
  let movies = ModelData().movies
  NavigationStack {
    MovieDetail(movie: movies.randomElement()!)
      .environment(Profile.default)
  }
}

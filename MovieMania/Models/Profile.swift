// Profile.swift
// MovieMania
//
// Created by Ben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

@Observable
final class Profile {
  var username: String
  var prefersNotifications: Bool
  var favoriteGenre: Genre
  var favoriteMovies: Set<Movie> = []
  
  init(username: String, prefersNotifications: Bool, favoriteGenre: Genre) {
    self.username = username
    self.prefersNotifications = prefersNotifications
    self.favoriteGenre = favoriteGenre
  }
  
  func setFavorite(for movie: Movie) {
    if favoriteMovies.contains(movie) {
      favoriteMovies.remove(movie)
    } else {
      favoriteMovies.insert(movie)
    }
  }
  
  static let `default` = Profile(username: "jAppleseed", prefersNotifications: true, favoriteGenre: .sciFi)
}

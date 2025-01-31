// Movie.swift
// MovieMania
//
// Created by Joben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

struct Movie: Hashable, Codable, Identifiable {
  let id: Int
  let voteAverage: Double
  let title: String
  let posterName: String
  let genre: Genre
  let overview: String
  let releaseDate: Date
  let isFeatured: Bool
  
  var posterImage: Image {
    Image(posterName)
  }
}

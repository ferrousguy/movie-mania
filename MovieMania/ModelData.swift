// ModelData.swift
// MovieMania
//
// Created by Joben Gohlke on Dec. 30, 2024.
// Copyright © 2025 Adapty. All rights reserved.
//

import Foundation

@Observable
class ModelData {
  var movies: [Movie] = load("nowplaying.json")

  var featured: [Movie] {
    movies.filter { $0.isFeatured }
  }

  var moviesByGenre: [String: [Movie]] {
    Dictionary(
      grouping: movies,
      by: { $0.genre.rawValue }
    )
  }
}

func load<T: Decodable>(_ filename: String) -> T {
  let data: Data
  
  guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
  else {
    fatalError("Couldn't find \(filename) in main bundle.")
  }
  
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
  }
  
  do {
    let decoder = JSONDecoder()
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    decoder.dateDecodingStrategy = .formatted(df)
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
  }
}

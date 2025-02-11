// Genre.swift
// MovieMania
//
// Created by Ben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

enum Genre: String, Hashable, Codable, CaseIterable {
  case action = "Action"
  case comedy = "Comedy"
  case drama = "Drama"
  case family = "Family"
  case horror = "Horror"
  case sciFi = "Sci-Fi"
  case fantasy = "Fantasy"
  
  var emoji: String {
    switch self {
      case .action:
        return "💪"
      case .comedy:
        return "😂"
      case .drama:
        return "🎭"
      case .family:
        return "🧑‍🧑‍🧒‍🧒"
      case .horror:
        return "🧟"
      case .sciFi:
        return "🛸"
      case .fantasy:
        return "🧙‍♂️"
    }
  }
}

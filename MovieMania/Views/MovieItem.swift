// MovieRow.swift
// MovieItem.swift
// MovieMania
//
// Created by Ben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import Foundation
import SwiftUI

struct MovieItem : View {
  var movie: Movie
  let showDate: Bool
  
  var body: some View {
    VStack(alignment: .leading) {
      movie.posterImage
        .resizable()
        .frame(width: 120, height: 180)
        .cornerRadius(8)
      
      if showDate {
        Text(movie.releaseDate, style: .date)
          .foregroundStyle(.primary)
          .font(.caption)
      }
    }
    .padding(.leading, 15)
  }
}

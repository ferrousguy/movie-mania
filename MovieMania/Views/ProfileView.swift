// ProfileView.swift
// MovieMania
//
// Created by Ben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @Environment(\.presentationMode) var presentationMode
  @Environment(ModelData.self) var modelData
  @Environment(Profile.self) var profile
  
  var body: some View {
    NavigationStack {
      List {
        ProfileListRow(labelText: "username", valueText: profile.username)
        
        ProfileListRow(labelText: "release date notifications", valueText: "Yes")
        
        ProfileListRow(labelText: "favorite genre", valueText: "\(profile.favoriteGenre.rawValue) \(profile.favoriteGenre.emoji)")
      
        if profile.favoriteMovies.count > 0 {
          MovieListRow(collectionName: "Favorite Movies", movies: Array(profile.favoriteMovies), showDate: false, isInset: true)
        }
      }
      .navigationTitle("Profile")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button("Done") {
            presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
  }
}

#Preview {
  ProfileView()
    .environment(ModelData())
    .environment(Profile.default)
}

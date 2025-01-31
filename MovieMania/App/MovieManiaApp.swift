// MovieManiaApp.swift
// MovieMania
//
// Created by Joben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

@main
struct MovieManiaApp: App {
  @State private var modelData = ModelData()
  @State private var profile = Profile(username: "jAppleseed", prefersNotifications: true, favoriteGenre: .sciFi)
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(modelData)
        .environment(profile)
    }
  }
}

// MovieManiaApp.swift
// MovieMania
//
// Created by Ben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI
import OSLog

@main
struct MovieManiaApp: App {
  let logger = Logger(subsystem: "io.adapty.MovieMania", category: "AppMain")
  
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

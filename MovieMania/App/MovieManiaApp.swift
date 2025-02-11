// MovieManiaApp.swift
// MovieMania
//
// Created by Ben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI
import OSLog
import Adapty
import AdaptyUI

@main
struct MovieManiaApp: App {
  let logger = Logger(subsystem: "io.adapty.MovieMania", category: "AppMain")
  
  @State private var modelData = ModelData()
  @State private var profile = Profile(username: "jAppleseed", prefersNotifications: true, favoriteGenre: .sciFi)
  @ObservedObject private var adaptyHelper: AdaptyHelper = AdaptyHelper()
  
  init() {
    let configurationBuilder = AdaptyConfiguration.builder(withAPIKey: AppConstants.Adapty.apiKey)
    
    Task {
      try await Adapty.activate(with: configurationBuilder)
      try await AdaptyUI.activate()
    }
  }
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ContentView()
          .environmentObject(adaptyHelper)
          .environment(modelData)
          .environment(profile)
          .task {
            do {
              try await adaptyHelper.refreshCustomeProfile()
            } catch {
              logger.error("Error refreshing customer profile on launch: \(error.localizedDescription)")
            }
          }
      }
    }
  }
}

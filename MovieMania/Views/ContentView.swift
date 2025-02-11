// ContentView.swift
// MovieMania
//
// Created by Ben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI
import OSLog
import Adapty
import AdaptyUI

struct ContentView: View {
  @Environment(ModelData.self) var modelData
  @EnvironmentObject var adaptyHelper: AdaptyHelper
  
  @State private var isPresentingProfile: Bool = false
  @State private var isPresentingPaywall: Bool = false
  @State private var paywallConfig: AdaptyUI.PaywallConfiguration?
  
  let logger = Logger(subsystem: "io.adapty.MovieMania", category: "ContentView")

  var body: some View {
    List {
      ForEach(modelData.moviesByGenre.keys.sorted(), id: \.self) { key in
        MovieListRow(collectionName: key, movies: modelData.moviesByGenre[key]!)
      }
      .listRowInsets(
        EdgeInsets(
          top: 0,
          leading: 0,
          bottom: 15,
          trailing: 0
        )
      )
    }
    .listStyle(.inset)
    .navigationTitle(Text("Now Playing"))
    .toolbar {
      Button {
        isPresentingProfile.toggle()
      } label: {
        Label("User Profile", systemImage: "person.crop.circle")
      }
    }
    .sheet(isPresented: $isPresentingProfile) {
      ProfileView()
    }
    .iflet(paywallConfig) { view, unwrappedPaywallConfig in
      view.paywall(
        isPresented: $isPresentingPaywall,
        fullScreen: false,
        paywallConfiguration: unwrappedPaywallConfig,
        didFinishPurchase: { product, purchaseResult in
          adaptyHelper.wasPurchased(with: purchaseResult)
          isPresentingPaywall = false
        },
        didFailPurchase: { _, error in
          isPresentingPaywall = false
          // present error to user and offer alternative
        },
        didFinishRestore: { profile in
          adaptyHelper.wasRestored(with: profile)
          isPresentingPaywall = false
        },
        didFailRestore: { error in
          isPresentingPaywall = false
          // present error to user and offer alternative
        },
        didFailRendering: { error in
          isPresentingPaywall = false
          // present error to user and offer alternative
        }
      )
    }
    .task {
      do {
        let paywall = try await Adapty.getPaywall(placementId: AppConstants.Adapty.Placement.onLaunch)
        paywallConfig = try await AdaptyUI.getPaywallConfiguration(forPaywall: paywall)
      } catch {
        logger.error("Error fetching paywall or paywall config: \(error.localizedDescription)")
      }
    }
  }
}

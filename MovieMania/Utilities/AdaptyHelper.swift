// AdaptyHelper.swift
// MovieMania
//
// Created by Ben Gohlke on 2/11/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import Foundation
import OSLog
import Adapty

final class AdaptyHelper: ObservableObject {
  @Published var customerProfile: AdaptyProfile? {
    didSet {
      subscriptionActive = customerProfile?.accessLevels[AppConstants.Adapty.accessLevelID]?.isActive == true
    }
  }
  @Published var paywall: AdaptyPaywall?
  @Published var paywallProduct: AdaptyPaywallProduct?
  @Published var subscriptionActive: Bool = false
  
  let logger = Logger(subsystem: "io.adapty.MovieMania", category: "Adapty Helper Service")
  private var deferredProduct: AdaptyDeferredProduct?
  
  var activeAccessLevel: AdaptyProfile.AccessLevel? {
    if let customerProfile,
       let accessLevel = customerProfile.accessLevels[AppConstants.Adapty.accessLevelID],
      accessLevel.isActive == true {
      return accessLevel
    } else { return nil }
  }
  
  @MainActor
  func refreshCustomeProfile() async throws {
    customerProfile = try await Adapty.getProfile()
  }
  
  func wasPurchased(with result: AdaptyPurchaseResult) {
    switch result {
      case .success(let profile, _):
        customerProfile = profile
      default:
        break
    }
  }
  
  func wasRestored(with profile: AdaptyProfile) {
    customerProfile = profile
  }
}

extension AdaptyHelper: AdaptyDelegate {
  func didLoadLatestProfile(_ profile: AdaptyProfile) {
    customerProfile = profile
  }
}

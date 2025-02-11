// View+.swift
// MovieMania
//
// Created by Ben Gohlke on 2/11/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

extension View {
  @ViewBuilder func `iflet`<Content: View, OptionalType>(_ optional: Optional<OptionalType>, transform: (Self, OptionalType) -> Content) -> some View {
    if let unwrapped = optional {
      transform(self, unwrapped)
    } else {
      self
    }
  }
}

// ProfileListRow.swift
// MovieMania
//
// Created by Ben Gohlke on 1/31/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

struct ProfileListRow: View {
  let labelText: String
  let valueText: String
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(labelText.uppercased())
        .font(.callout)
        .foregroundStyle(.secondary)
      
      Spacer()
      
      Text(valueText)
        .bold()
    }
  }
}

#Preview {
  ProfileListRow(labelText: "username", valueText: "j_appleseed")
}

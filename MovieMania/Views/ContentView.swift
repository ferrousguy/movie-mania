// ContentView.swift
// MovieMania
//
// Created by Joben Gohlke on 1/2/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @Environment(ModelData.self) var modelData
  
  @State private var isPresentingProfile: Bool = false
  
  var body: some View {
    NavigationStack {
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
    }
  }
}

#Preview {
  ContentView()
    .environment(ModelData())
    .environment(Profile.default)
}

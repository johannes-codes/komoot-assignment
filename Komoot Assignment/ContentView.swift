//
//  ContentView.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 14.07.24.
//

import SwiftUI

struct ContentView: View {
    @State private var isTracking = false
    @State private var photos: [String] = []

    var body: some View {
        VStack {
            Button(isTracking ? "Stop" : "Start", action: startStopTracking)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)

            ScrollView(showsIndicators: false) {

                ForEach(photos, id: \.self) { imageUrl in

                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
        }
    }

    private func startStopTracking() {
        switch isTracking {
        case true: break
            // End Tracking
        case false: break
            // Start Tracking
        }

        isTracking.toggle()
    }
}

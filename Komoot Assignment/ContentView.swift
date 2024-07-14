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
    @ObservedObject private var coordinator = Coordinator()

    var body: some View {
        VStack {
            Button(isTracking ? "Stop" : "Start", action: startStopTracking)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)

            ScrollView(showsIndicators: false) {
                ForEach(coordinator.photoStream, id: \.self) { imageUrl in
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .clipped()
                                .transition(.move(edge: .top))
                        } else if phase.error != nil {
                            Color.red
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .transition(.move(edge: .top))
                                .overlay {
                                    Text("Something went wrong while loading the image or no image was available.")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                }
                        } else {
                            ProgressView("Loading")
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
        }
        .onAppear {
            coordinator.requestLocationAccess()
        }
    }

    private func startStopTracking() {
        switch isTracking {
        case true:
            coordinator.stopWaling()
        case false:
            coordinator.startWalking()
        }

        isTracking.toggle()
    }
}

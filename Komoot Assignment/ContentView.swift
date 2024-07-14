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
                    Text(imageUrl)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
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

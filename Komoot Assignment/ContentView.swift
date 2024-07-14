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
    private var locationManager: LocationManagerProtocol = LocationManager()

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
        .onAppear {
            locationManager.requestLocationAccess()
        }
    }

    private func startStopTracking() {
        switch isTracking {
        case true:
            locationManager.stopTracking()
        case false:
            locationManager.startTracking()
        }

        isTracking.toggle()
    }
}

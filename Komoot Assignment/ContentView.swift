//
//  ContentView.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 14.07.24.
//

import CoreLocationUI
import SwiftUI

struct ContentView: View {
    @ObservedObject private var coordinator: Coordinator
    @State private var isTracking = false
    @State private var showTrackingConsent = false
    @State private var errorMessage: String = ""
    @State private var hintMessage: String = ""
    @State private var photos: [String] = []

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        VStack {
            HStack {
                Button("Clear", action: clearResults)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .disabled(isTracking)
                    .disabled(coordinator.photoStream.isEmpty)

                Button(isTracking ? "Stop" : "Start", action: startStopTracking)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .disabled(showTrackingConsent)

            ScrollView(showsIndicators: false) {
                if !errorMessage.isEmpty {
                    Text("\(Image(systemName: "exclamationmark.triangle.fill")) \(errorMessage)")
                        .frame(maxWidth: .infinity)
                        .font(.system(.footnote))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(.red.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                if !hintMessage.isEmpty {
                    Text("\(Image(systemName: "info.circle")) \(hintMessage)")
                        .frame(maxWidth: .infinity)
                        .font(.system(.footnote))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(.gray.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
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
        .overlay {
            if showTrackingConsent {
                VStack(alignment: .center, spacing: 25) {
                    Text("This app needs access to your permanent location to track your walk.")
                        .font(.system(.callout))
                        .multilineTextAlignment(.center)

                    LocationButton(.shareCurrentLocation) {
                        coordinator.requestAlwaysAuthorization()
                    }
                    .cornerRadius(20)
                    .labelStyle(.titleAndIcon)
                    .symbolVariant(.fill)
                    .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
            }
        }
        .overlay {
            if coordinator.photoStream.isEmpty, isTracking {
                Text("Start walking...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 16)
            }
        }
        .onChange(of: coordinator.locationAccess) { _, _ in
            evaluateLocationConsent()
        }
        .onAppear {
            evaluateLocationConsent()
        }
    }

    private func evaluateLocationConsent() {
        let access = coordinator.locationAccess
        switch access {
        case .authorizedWhenInUse:
            set(hintMessage: "Your location is tracked only when the iPhone is unlocked and the app is open.")
        case .denied, .restricted:
            set(errorMessage: "Access to your location has been denied, so tracking is not possible.")
        default:
            resetMessages()
        }

        showTrackingConsent = access == .notDetermined
    }

    private func resetMessages() {
        errorMessage = ""
        hintMessage = ""
    }

    private func set(errorMessage: String? = nil, hintMessage: String? = nil) {
        if let errorMessage {
            self.errorMessage = errorMessage
            self.hintMessage = ""
        } else if let hintMessage {
            self.hintMessage = hintMessage
            self.errorMessage = ""
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

    private func clearResults() {
        coordinator.clearList()
    }
}

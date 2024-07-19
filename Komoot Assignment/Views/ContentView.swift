//
//  ContentView.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 14.07.24.
//

import CoreLocation
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
            ControlButtons(
                isTracking: $isTracking,
                showTrackingConsent: $showTrackingConsent,
                coordinator: coordinator,
                clearResults: clearResults,
                startStopTracking: startStopTracking
            )

            ScrollView(showsIndicators: false) {
                if !errorMessage.isEmpty {
                    MessageView(message: errorMessage, isError: true)
                }
                if !hintMessage.isEmpty {
                    MessageView(message: hintMessage, isError: false)
                }
                PhotoStreamView(photoStream: coordinator.photoStream)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
        }
        .overlay {
            if showTrackingConsent {
                TrackingConsentView(coordinator: coordinator)
            }
        }
        .overlay {
            if coordinator.photoStream.isEmpty, isTracking {
                Text("Start walking...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 16)
            }
        }
        .onChange(of: coordinator.locationAccess) { _, newValue in
            evaluateLocationConsent(newValue)
        }
        .onAppear {
            evaluateLocationConsent()
        }
    }

    private func evaluateLocationConsent(_ consent: CLAuthorizationStatus = .notDetermined) {
        switch consent {
        case .authorizedWhenInUse:
            set(hintMessage: "Your location is tracked only when the iPhone is unlocked and the app is open.")
        case .denied, .restricted:
            set(errorMessage: "Access to your location has been denied, so tracking is not possible.")
        default:
            resetMessages()
        }

        showTrackingConsent = consent == .notDetermined
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

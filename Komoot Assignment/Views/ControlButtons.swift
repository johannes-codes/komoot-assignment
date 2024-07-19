//
//  ControlButtons.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 19.07.24.
//

import SwiftUI

struct ControlButtons: View {
    @Binding var isTracking: Bool
    @Binding var showTrackingConsent: Bool
    var coordinator: Coordinator
    var clearResults: () -> Void
    var startStopTracking: () -> Void

    var body: some View {
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
    }
}

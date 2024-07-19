//
//  TrackingConsentView.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 19.07.24.
//

import SwiftUI
import CoreLocationUI

struct TrackingConsentView: View {
    var coordinator: Coordinator

    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Text("This app needs access to your permanent location to track your walk.")
                .font(.system(.callout))
                .multilineTextAlignment(.center)

            LocationButton(.shareCurrentLocation) {
                coordinator.requestAuthorization()
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


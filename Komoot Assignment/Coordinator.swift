//
//  Coordinator.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 14.07.24.
//

import SwiftUI
import CoreLocation

final class Coordinator: ObservableObject {
    @Published var photoStream: [String] = []
    @Published var locationAccess: CLAuthorizationStatus = .notDetermined

    private var locationManager: LocationManagerProtocol

    init(locationManager: LocationManagerProtocol = LocationManager()) {
        self.locationManager = locationManager
        self.locationManager.delegate = self
    }

    func startWalking() {
        locationManager.startTracking()
    }

    func stopWaling() {
        locationManager.stopTracking()
    }

    func requestLocationAccess() {
        locationManager.requestLocationAccess()
    }
}

extension Coordinator: LocationUpdateDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        DispatchQueue.main.async {
            self.photoStream.insert(location.description, at: 0)
        }
    }

    func didUpdateAuthorization() {
        locationAccess = locationManager.getLocationAccess()
    }
}

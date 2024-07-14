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
    private var flickerService: FlickerServiceProtocol

    init(
        locationManager: LocationManagerProtocol = LocationManager(),
        flickerService: FlickerServiceProtocol = FlickerService()
    ) {
        self.locationManager = locationManager
        self.flickerService = flickerService
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
        flickerService.fetchPhoto(for: location) { [weak self] result in
            switch result {
            case .success(let url):
                DispatchQueue.main.async {
                    withAnimation {
                        self?.photoStream.insert(url, at: 0)
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func didUpdateAuthorization() {
        locationAccess = locationManager.getLocationAccess()
    }
}

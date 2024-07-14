//
//  LocationManager.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 14.07.24.
//

import CoreLocation

protocol LocationUpdateDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
    func didUpdateAuthorization()
}

protocol LocationManagerProtocol {
    var delegate: LocationUpdateDelegate? { get set }

    func startTracking()
    func stopTracking()
    func getLocationAccess() -> CLAuthorizationStatus
    func requestAlwaysAuthorization()
}

final class LocationManager: NSObject, LocationManagerProtocol {
    private var locationManager: CLLocationManager
    private var lastLocation: CLLocation?
    private var photoStream: [String] = []

    weak var delegate: LocationUpdateDelegate?

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager

        super.init()
        self.locationManager.delegate = self
    }

    func startTracking() {
        locationManager.startUpdatingLocation()
    }

    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }

    func getLocationAccess() -> CLAuthorizationStatus {
        locationManager.authorizationStatus
    }

    func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }

        if let lastLocation = lastLocation {
            let distance = newLocation.distance(from: lastLocation)
            if distance >= 100 {
                delegate?.didUpdateLocation(newLocation)
                self.lastLocation = newLocation
            }
        } else {
            lastLocation = newLocation
        }

        print(newLocation.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        delegate?.didUpdateAuthorization()
    }
}

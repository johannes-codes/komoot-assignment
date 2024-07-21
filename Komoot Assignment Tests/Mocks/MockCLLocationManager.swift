//
//  MockCLLocationManager.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 21.07.24.
//

import CoreLocation

final class MockCLLocationManager: CLLocationManager {
    var requestWhenInUseAuthorizationInvocations = 0
    var didCallRequestWhenInUseAuthorization = false

    var requestAlwaysAuthorizationInvocations = 0
    var didCallRequestAlwaysAuthorization = false

    var startUpdatingLocationInvocations = 0
    var didCallStartUpdatingLocation = false

    var stopUpdatingLocationInvocations = 0
    var didCallStopUpdatingLocation = false

    var authorizationStatusInvocations = 0
    var didCallAuthorizationStatus = false
    var authorizationStatusResponse = CLAuthorizationStatus.notDetermined

    override func requestWhenInUseAuthorization() {
        requestWhenInUseAuthorizationInvocations += 1
        didCallRequestWhenInUseAuthorization = true
    }

    override func requestAlwaysAuthorization() {
        requestAlwaysAuthorizationInvocations += 1
        didCallRequestAlwaysAuthorization = true
    }

    override func startUpdatingLocation() {
        startUpdatingLocationInvocations += 1
        didCallStartUpdatingLocation = true
    }

    override func stopUpdatingLocation() {
        stopUpdatingLocationInvocations += 1
        didCallStopUpdatingLocation = true
    }

    override var authorizationStatus: CLAuthorizationStatus {
        authorizationStatusInvocations += 1
        didCallAuthorizationStatus = true
        return authorizationStatusResponse
    }

    func triggerLocationMangerDidUpdateLocations(with locations: [CLLocation]) {
        delegate?.locationManager?(self, didUpdateLocations: locations)
    }

    func triggerLocationManagerChangeAuthorization() {
        delegate?.locationManagerDidChangeAuthorization?(self)
    }
}

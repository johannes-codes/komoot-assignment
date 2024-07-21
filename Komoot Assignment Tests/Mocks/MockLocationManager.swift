//
//  MockLocationManager.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 19.07.24.
//

import CoreLocation
import Foundation

class MockLocationManager: LocationManagerProtocol {
    var startTrackingInvocations = 0
    var didCallStartTracking = false

    var stopTrackingInvocations = 0
    var didCallStopTracking = false

    var getLocationAccessInvocations = 0
    var didCallGetLocationAccess = false
    var getLocationAccessResponse = CLAuthorizationStatus.notDetermined

    var requestWhenInUseAuthorizationInvocations = 0
    var didCallRequestWhenInUseAuthorization = false

    var requestAlwaysAuthorizationInvocations = 0
    var didCallRequestAlwaysAuthorization = false

    var delegate: (any LocationUpdateDelegate)?
    
    func startTracking() {
        startTrackingInvocations += 1
        didCallStartTracking = true
    }
    
    func stopTracking() {
        stopTrackingInvocations += 1
        didCallStopTracking = true
    }
    
    func getLocationAccess() -> CLAuthorizationStatus {
        getLocationAccessInvocations += 1
        didCallGetLocationAccess = true
        return getLocationAccessResponse
    }
    
    func requestWhenInUseAuthorization() {
        requestWhenInUseAuthorizationInvocations += 1
        didCallRequestWhenInUseAuthorization = true
    }
    
    func requestAlwaysAuthorization() {
        requestAlwaysAuthorizationInvocations += 1
        didCallRequestAlwaysAuthorization = true
    }

    func triggerDidUpdateLocation(with location: CLLocation) {
        delegate?.didUpdateLocation(location)
    }
}

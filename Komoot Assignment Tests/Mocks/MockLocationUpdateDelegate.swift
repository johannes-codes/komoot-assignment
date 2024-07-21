//
//  MockLocationUpdateDelegate.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 21.07.24.
//

import CoreLocation
import Foundation

final class MockLocationUpdateDelegate: LocationUpdateDelegate {
    var didUpdateLocationInvocations = 0
    var didUpdateLocationParameters: [CLLocation] = []

    var didUpdateAuthorizationInvocations = 0
    var didUpdateAuthorizationParameters: [CLAuthorizationStatus] = []

    func didUpdateLocation(_ location: CLLocation) {
        didUpdateLocationInvocations += 1
        didUpdateLocationParameters.append(location)
    }

    func didUpdateAuthorization(with status: CLAuthorizationStatus) {
        didUpdateAuthorizationInvocations += 1
        didUpdateAuthorizationParameters.append(status)
    }
}

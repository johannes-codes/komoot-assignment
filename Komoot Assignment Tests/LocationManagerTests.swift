//
//  LocationManagerTests.swift
//  Komoot AssignmentTests
//
//  Created by Meißner, Johannes on 21.07.24.
//

import CoreLocation
import XCTest
@testable import Komoot_Assignment

final class LocationManagerTests: XCTestCase {

    var sut: LocationManager!
    var mockCLLocationManager: MockCLLocationManager!
    var mockLocationUpdateDelegate: MockLocationUpdateDelegate!

    override func setUp() {
        super.setUp()
        mockCLLocationManager = MockCLLocationManager()
        mockLocationUpdateDelegate = MockLocationUpdateDelegate()
        sut = LocationManager(locationManager: mockCLLocationManager)
    }

    func testStartTracking() {
        // When
        sut.startTracking()

        // Then
        XCTAssertEqual(mockCLLocationManager.didCallStartUpdatingLocation, true)
    }

    func testStopTracking() {
        // When
        sut.stopTracking()

        // Then
        XCTAssertEqual(mockCLLocationManager.didCallStopUpdatingLocation, true)
    }

    func testGetLocationAccess() {
        // Given
        let access = CLAuthorizationStatus.authorizedWhenInUse
        mockCLLocationManager.authorizationStatusResponse = access

        // When
        let result = sut.getLocationAccess()

        // Then
        XCTAssertEqual(result, access)
    }

    func testRequestWhenInUseAuthorization() {
        // When
        sut.requestWhenInUseAuthorization()

        // Then
        XCTAssertEqual(mockCLLocationManager.requestWhenInUseAuthorizationInvocations, 1)
        XCTAssertEqual(mockCLLocationManager.didCallRequestWhenInUseAuthorization, true)
    }

    func testRequestAlwaysAuthorization() {
        // When
        sut.requestAlwaysAuthorization()

        // Then
        XCTAssertEqual(mockCLLocationManager.requestAlwaysAuthorizationInvocations, 1)
        XCTAssertEqual(mockCLLocationManager.didCallRequestAlwaysAuthorization, true)
    }

    func testDidUpdateLocationsDelegate() {
        // Given
        sut.delegate = mockLocationUpdateDelegate
        // When
        let firstLocation = [CLLocation(latitude: 1, longitude: 1)]
        mockCLLocationManager.triggerLocationMangerDidUpdateLocations(with: firstLocation)

        let secondLocation = [CLLocation(latitude: 37.7749, longitude: -122.4194)]
        mockCLLocationManager.triggerLocationMangerDidUpdateLocations(with: secondLocation)

        // Then
        XCTAssertEqual(mockLocationUpdateDelegate.didUpdateLocationInvocations, 1)
        XCTAssertEqual(mockLocationUpdateDelegate.didUpdateLocationParameters, secondLocation)
    }

    func testDidChangeAuthorizationDelegate() {
        // Given
        sut.delegate = mockLocationUpdateDelegate
        mockCLLocationManager.authorizationStatusResponse = .denied

        // When
        mockCLLocationManager.triggerLocationManagerChangeAuthorization()

        // Then
        XCTAssertEqual(mockLocationUpdateDelegate.didUpdateAuthorizationInvocations, 1)
        XCTAssertEqual(mockLocationUpdateDelegate.didUpdateAuthorizationParameters, [.denied])
    }
}

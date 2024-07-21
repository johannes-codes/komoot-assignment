//
//  CoordinatorTests.swift
//  Komoot AssignmentTests
//
//  Created by Meißner, Johannes on 19.07.24.
//

import CoreLocation
@testable import Komoot_Assignment
import XCTest

final class CoordinatorTests: XCTestCase {

    var sut: Coordinator!
    var mockLocationManager: MockLocationManager!
    var mockFlickerService: MockFlickerService!

    override func setUp() {
        super.setUp()
        mockLocationManager = MockLocationManager()
        mockFlickerService = MockFlickerService()
        sut = Coordinator(
            locationManager: mockLocationManager,
            flickerService: mockFlickerService
        )
    }

    func testStartWalking() {
        // When
        sut.startWalking()

        // Then
        XCTAssertEqual(mockLocationManager.startTrackingInvocations, 1)
        XCTAssertTrue(mockLocationManager.didCallStartTracking)
    }

    func testStopWalking() {
        // When
        sut.stopWaling()

        // Then
        XCTAssertEqual(mockLocationManager.stopTrackingInvocations, 1)
        XCTAssertTrue(mockLocationManager.didCallStopTracking)
    }

    func testRequestAuthorization() {
        // When
        sut.requestAuthorization()

        // Then
        XCTAssertEqual(mockLocationManager.requestWhenInUseAuthorizationInvocations, 1)
        XCTAssertTrue(mockLocationManager.didCallRequestWhenInUseAuthorization)
    }

    func testClearList() {
        // Given
        sut.photoStream = ["test"]

        // When
        sut.clearList()

        // Then
        XCTAssertTrue(sut.photoStream.isEmpty)
    }

    func testDidUpdateLocation() {
        // Given
        let location = CLLocation(latitude: 0, longitude: 0)
        let url = "https://google.de"

        // When
        mockFlickerService.fetchPhotoResult = .success(url)
        mockLocationManager.delegate?.didUpdateLocation(location)

        // Then
        XCTAssertEqual(mockFlickerService.fetchPhotoInvocations, 1)
        XCTAssertTrue(mockFlickerService.didCallFetchPhoto)
        XCTAssertEqual(sut.photoStream, [url])
    }

    func testDidUpdateAuthorizationNotDetermined() {
        // Given
        let status: CLAuthorizationStatus = .notDetermined

        // When
        mockLocationManager.delegate?.didUpdateAuthorization(with: status)

        // Then
        XCTAssertEqual(sut.locationAccess, status)
    }

    func testDidUpdateAuthorizationWhenInUse() {
        // Given
        let status: CLAuthorizationStatus = .authorizedWhenInUse

        // When
        mockLocationManager.delegate?.didUpdateAuthorization(with: status)

        // Then
        XCTAssertEqual(sut.locationAccess, status)
        XCTAssertEqual(mockLocationManager.requestAlwaysAuthorizationInvocations, 1)
        XCTAssertTrue(mockLocationManager.didCallRequestAlwaysAuthorization)
    }
}

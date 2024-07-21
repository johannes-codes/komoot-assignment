//
//  MockFlickerService.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 21.07.24.
//

import Foundation
import CoreLocation

class MockFlickerService: FlickerServiceProtocol {
    var fetchPhotoInvocations: Int = 0
    var didCallFetchPhoto: Bool = false
    var fetchPhotoResult: Result<String, PhotoFetchError>?

    func fetchPhoto(
        for location: CLLocation,
        completion: @escaping (Result<String, PhotoFetchError>) -> Void
    ) {
        fetchPhotoInvocations += 1
        didCallFetchPhoto = true

        if let fetchPhotoResult = fetchPhotoResult {
            completion(fetchPhotoResult)
        }
    }
}

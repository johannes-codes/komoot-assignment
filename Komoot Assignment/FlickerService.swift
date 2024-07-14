//
//  FlickerService.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 14.07.24.
//

import CoreLocation

enum PhotoFetchError: Error {
    case networkError
    case parsingError
    case unknownError
}

protocol FlickerServiceProtocol {
    func fetchPhoto(for location: CLLocation, completion: @escaping (Result<String, PhotoFetchError>) -> Void)
}

final class FlickerService: FlickerServiceProtocol {
    private let apiKey = "196791c930642bab389022402b9b7136"

    /// Fetches a photo for the given location.
    /// - Parameters:
    ///   - location: The location for which to fetch the photo.
    ///   - completion: The completion handler returning a Result with the photo URL or an error.
    func fetchPhoto(for location: CLLocation, completion: @escaping (Result<String, PhotoFetchError>) -> Void) {
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&per_page=20"

        guard let url = URL(string: urlString) else {
            completion(.failure(.networkError))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.networkError))
                return
            }
            
            if let photoUrl = self.extractPhoto(from: data) {
                completion(.success(photoUrl))
            } else {
                completion(.failure(.parsingError))
            }
        }.resume()
    }

    private func extractPhoto(from data: Data) -> String? {
        let parser = PhotosParser()

        if let photosResponse = parser.parse(data: data) {
            guard let photo = photosResponse.photos.randomElement() else { return nil }
            return "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        } else {
            print("Failed to parse XML")
        }

        return nil
    }
}

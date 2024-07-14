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
            
            // TODO: Parse the XML response

            print(String(data: data, encoding: .utf8) ?? "")

        }.resume()
    }
}

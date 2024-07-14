//
//  PhotosParser.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 14.07.24.
//

import Foundation

struct Photo {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: String
    let title: String
    let isPublic: Bool
    let isFriend: Bool
    let isFamily: Bool
}

struct PhotoResponse {
    var photos: [Photo] = []
}

class PhotosParser: NSObject, XMLParserDelegate {
    private var currentElement = ""
    private var currentPhoto: Photo?
    private var photosResponse = PhotoResponse()

    func parse(data: Data) -> PhotoResponse? {
        let parser = XMLParser(data: data)
        parser.delegate = self
        if parser.parse() {
            return photosResponse
        } else {
            return nil
        }
    }

    // MARK: - XMLParserDelegate Methods
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        currentElement = elementName
        if elementName == "photo" {
            currentPhoto = Photo(
                id: attributeDict["id"] ?? "",
                owner: attributeDict["owner"] ?? "",
                secret: attributeDict["secret"] ?? "",
                server: attributeDict["server"] ?? "",
                farm: attributeDict["farm"] ?? "",
                title: attributeDict["title"] ?? "",
                isPublic: attributeDict["ispublic"] == "1",
                isFriend: attributeDict["isfriend"] == "1",
                isFamily: attributeDict["isfamily"] == "1"
            )
        }
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        if elementName == "photo" {
            if let photo = currentPhoto {
                photosResponse.photos.append(photo)
            }
            currentPhoto = nil
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // Handle character data if needed
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parse error: \(parseError.localizedDescription)")
    }
}

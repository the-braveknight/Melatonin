//
//  UnsplashEndpoint.swift
//  Example
//
//  Created by Zaid Rahhawi on 25/06/2024.
//

import Foundation
import Melatonin

protocol UnsplashEndpoint: Endpoint {}

extension UnsplashEndpoint {
    var host: String { "api.unsplash.com" }
}

struct PhotosEndpoint: UnsplashEndpoint {
    typealias Response = [Photo]
    
    let path: String = "/photos"
    
    @Query(name: "page") var page: Int = 1
    
    var headers: [any HTTPHeader] {
        Authorization(.bearer(token: "Yer4njZkF-Xd8X0JdlalAHPfoLInfy1lAco31vlWp6Q"))
    }
}

struct Photo: Decodable, Identifiable {
    let id: String
    let description: String
    let image: URL
    
    private enum CodingKeys: String, CodingKey {
        case id
        case description = "alt_description"
        case urls = "urls"
    }
    
    private enum URLCodingKeys: String, CodingKey {
        case regular
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        
        let urlsContainer = try container.nestedContainer(keyedBy: URLCodingKeys.self, forKey: .urls)
        self.image = try urlsContainer.decode(URL.self, forKey: .regular)
    }
}

extension Endpoint where Self == PhotosEndpoint {
    static func photos(page: Int, recordsPerPage: Int) -> Self {
        PhotosEndpoint(page: page)
    }
}

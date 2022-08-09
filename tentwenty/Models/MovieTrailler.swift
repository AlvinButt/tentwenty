//
//  MovieTrailler.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import Foundation

// MARK: - MovieTrailler
struct MovieTrailler: Codable {
    let results: [Result]
    let id: Int
}

// MARK: - Result
struct Result: Codable {
    let site: Site
    let official: Bool
    let id, publishedAt: String
    let size: Int
    let iso639_1: ISO639_1
    let key: String
    let iso3166_1: ISO3166_1
    let name: String
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case site, official, id
        case publishedAt = "published_at"
        case size
        case iso639_1 = "iso_639_1"
        case key
        case iso3166_1 = "iso_3166_1"
        case name, type
    }
}

enum ISO3166_1: String, Codable {
    case us = "US"
}

enum ISO639_1: String, Codable {
    case en = "en"
}

enum Site: String, Codable {
    case youTube = "YouTube"
}

enum TypeEnum: String, Codable {
    case behindTheScenes = "Behind the Scenes"
    case bloopers = "Bloopers"
    case clip = "Clip"
    case featurette = "Featurette"
    case teaser = "Teaser"
    case trailer = "Trailer"
}

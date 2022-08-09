//
//  GenerList.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import Foundation
// MARK: - GenerList
struct GenerList: Codable {
    
    // MARK: - Singleton
    private static var movieGener: GenerList?

    static var movie: GenerList? {
        if let gener = movieGener {
            return gener
        }
        return nil
    }
    
    static func setGenerList(_ gener: GenerList) {
        movieGener = gener
    }
    
    let genres: [Genre]
    
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

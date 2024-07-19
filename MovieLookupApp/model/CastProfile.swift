//
//  CastProfile.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 19/07/24.
//

import Foundation

struct CastProfile: Decodable, Identifiable {
    let birthday: String
    let id: Int
    let name: String
    let profile_path: String?
    
    var photoUrl: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w200")
        return baseUrl?.appending(path: profile_path ?? "")
    }
}

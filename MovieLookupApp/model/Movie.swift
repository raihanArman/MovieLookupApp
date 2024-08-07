//
//  TrendingItem.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 17/07/24.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String?
    
    var backdropUrl: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500")!
        return baseUrl.appending(path: backdrop_path ?? "")
    }
    
    var postThumbnail: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w100")!
        return baseUrl.appending(path: poster_path ?? "")
    }
    
    static var preview: Movie {
        return Movie(
            adult: false, id: 2434343, poster_path: "", title: "", overview: "", vote_average: 0.0, backdrop_path: ""
        )
    }
    
}

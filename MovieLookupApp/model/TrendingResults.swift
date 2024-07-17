//
//  TrendingResult.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 17/07/24.
//

import Foundation

struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

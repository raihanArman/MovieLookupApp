//
//  MovieDBViewModel.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 17/07/24.
//

import Foundation
@MainActor
class MovieDBViewModel: ObservableObject {
    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []
    
    let apiKey = "0027a40637be10414a5f22100bb4dda8"
    let domain = "https://api.themoviedb.org/3"
    
    init() {
        
    }
    
    func loadTrending() {
        Task {
            let url = URL(string: "\(domain)/trending/movie/day?api_key=\(apiKey)")!
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("SUCCESS")
                } else {
                    print("Error!!")
                }
                
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func search(text: String) {
        Task {
            let url = URL(string: "\(domain)/search/movie?api_key=\(apiKey)&page=1&query=\(text)")!
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("Search SUCCESS")
                } else {
                    print("Search ERRORR")
                }
                
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                searchResults = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

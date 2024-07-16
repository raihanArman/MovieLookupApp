//
//  ContentView.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 16/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.trending.isEmpty {
                Text("No Results")
            } else {
                HStack {
                    Text("Trending")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.trending) { trendingItem in
                            TrendingCardView(trendingItem: trendingItem)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .background(Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea())
        .onAppear {
            viewModel.loadTrending()
        }
    }
}

struct TrendingCardView: View {
    let trendingItem: TrendingItem
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trendingItem.backdropUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 200)
            } placeholder: {
                ZStack {
                    Rectangle().fill(Color(red: 61/255, green: 61/255, blue: 88/255))
                        .frame(width: 340, height: 200)
                    ProgressView()
                }
            }
//            
            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", trendingItem.vote_average))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .background(Color(red: 61/255, green: 61/255, blue: 88/255))
        }
        .cornerRadius(8.0)
    }
}

@MainActor
class MovieDBViewModel: ObservableObject {
    @Published var trending: [TrendingItem] = []
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
    
}

struct TrendingResults: Decodable {
    let page: Int
    let results: [TrendingItem]
    let total_pages: Int
    let total_results: Int
}

struct TrendingItem: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
    let backdrop_path: String
    
    var backdropUrl: URL {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500")!
        return baseUrl.appending(path: backdrop_path)
    }
    
}

#Preview {
    ContentView()
}

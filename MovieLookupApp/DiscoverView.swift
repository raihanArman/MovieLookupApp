//
//  ContentView.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 16/07/24.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject var viewModel = MovieDBViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if searchText.isEmpty {
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
                                    NavigationLink {
                                        MoviewDetailView(movie: trendingItem)
                                    } label: {
                                        TrendingCardView(trendingItem: trendingItem)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                } else {
                    LazyVStack {
                        ForEach(viewModel.searchResults) { item in
                            HStack {
                                AsyncImage(url: item.postThumbnail) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 120)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 80, height: 120)
                                }
                                .clipped()
                                .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                            .foregroundColor(.yellow)
                                        Text(String(format: "%.1f", item.vote_average))
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
            .background(Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea())

        }
        .searchable(text: $searchText)
        .onChange(of: searchText) {
            if searchText.count > 2 {
                viewModel.search(text: searchText)
            }
        }
        .onAppear {
            viewModel.loadTrending()
        }
    }
}


#Preview {
    DiscoverView()
}

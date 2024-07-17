//
//  TrendingCardView.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 17/07/24.
//

import Foundation
import SwiftUI


struct TrendingCardView: View {
    let trendingItem: Movie
    
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
        .frame(width: 340, height: 200)
    }
}

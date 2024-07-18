//
//  MoviewDetailView.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 18/07/24.
//

import SwiftUI

struct MoviewDetailView: View {
    @Environment(\.dismiss) var dismiss
    let movie: Movie
    let headerHeight: CGFloat = 400
    
    var body: some View {
        ZStack {
            Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: headerHeight)
                            .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
            }
            
            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: headerHeight)
        
                    HStack {
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.heavy)
                        Spacer()
                    }
                    
                    HStack {
                        
                    }
                    
                    HStack {
                        Text("About films")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Text(movie.overview)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
            }
            .padding()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    MoviewDetailView(movie: Movie.preview)
}

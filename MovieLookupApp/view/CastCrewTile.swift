//
//  CastCrewTile.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 19/07/24.
//

import SwiftUI

struct CastCrewTile: View {
    let cast: CastProfile
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: cast.photoUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 120)
            }
            Text(cast.name)
                .frame(width: 100)
        }
    }
}

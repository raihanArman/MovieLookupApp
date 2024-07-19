//
//  MovieDetailViewModel.swift
//  MovieLookupApp
//
//  Created by Raihan Arman on 19/07/24.
//

import Foundation

@MainActor
class MoviewDetailViewModel: ObservableObject {
    @Published var credits: MovieCredits?
    @Published var cast: [MovieCredits.Cast] = []
    @Published var castProfiles: [CastProfile] = []
    
    let apiKey = "0027a40637be10414a5f22100bb4dda8"
    let domain = "https://api.themoviedb.org/3"
    
    func movieCredit(for movieId: Int) async {
        let url = URL(string: "\(domain)/movie/\(movieId)/credits?api_key=\(apiKey)")!
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let credits = try JSONDecoder().decode(MovieCredits.self, from: data)
            self.credits = credits
            self.cast = credits.cast.sorted(by: { $0.order < $1.order })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadCastProfiles() async {
        do {
            for member in cast {
                let url = URL(string: "\(domain)/person/\(member.id)?api_key=\(apiKey)")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let profile = try JSONDecoder().decode(CastProfile.self, from: data)
                castProfiles.append(profile.self)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
